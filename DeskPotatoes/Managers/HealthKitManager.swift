//
//  HealthKitManager.swift
//  DeskPotatoes
//
//  Created by Darren Powers on 23/10/2018.
//  Copyright © 2018 Darren Powers. All rights reserved.
//

/* Health Kit Manager: Darren Powers
 * This file specifies the HealthKitManager class which performs actions related to accessing
 * and writing data from/to HealthKit
 */

import Foundation
import HealthKit
import UIKit

class HealthKitManager {
    
    // Create a Health Kit Store
    let healthKitStore: HKHealthStore = HKHealthStore()
    
    func authorizeHealthKit(share: Set<HKSampleType>?, read: Set<HKObjectType>?, completion:( (_ success: Bool, _ error: NSError?) -> Void )!){
        /* Authorize Health Kit: Darren Powers
         * This function performs the work of authorizing access to HealthKit
         */
        
        // Verify HealthKit data is available
        if !HKHealthStore.isHealthDataAvailable() {
            print("Health Kit Data Unavailable on this Device")
            return
        }
        // Actually request the authorization from HealthKit
        healthKitStore.requestAuthorization(toShare: share, read: read) { success, error in
            guard error == nil, success else {
                print(error!)
                return
            }
        }
    }
    
    func shareData(dataType: HKQuantityTypeIdentifier, value: Double, date: NSDate, completion:((HKSample?, NSError?) -> Void)!) {
        /* Share Data: Darren Powers
         * This function takes a HealthKit quantity type identifier a value (a number), and a date as parameters
         * and does the work of saving the data appropriately to HealthKit
         */
        
        //Make sure permissions granted for specific data type
        let authorizeShare = Set(arrayLiteral: HKObjectType.quantityType(forIdentifier: dataType))
        authorizeHealthKit(share: (authorizeShare as! Set<HKSampleType>), read: nil) { (success, error) -> Void in
            if !success {
                print("Unable to get permissions")
            }
        }
        
        //set quantity type
        let quantityType = HKQuantityType.quantityType(forIdentifier: dataType)
        
        //set quantity units appropriately
        var quantity: HKQuantity? = nil
        switch dataType {
        case .distanceWalkingRunning:
            quantity = HKQuantity(unit: HKUnit.mile(), doubleValue: value)
        default:
            print("shareData error")
        }
        
        //set Quantity Sample
        let sample = HKQuantitySample(type: quantityType!, quantity: quantity!, start: date as Date, end: date as Date)
        
        // Save Quantity Sample to the HealthKit Store
        healthKitStore.save(sample, withCompletion: { (success, error) -> Void in
            if( error != nil ) {
                print(error!)
            } else {
                print("The sample has been recorded! Better go check!")
            }
        })
    }
    
    func readData(dataType: HKObjectType, completion:((HKObject?, NSError?) -> Void)!) {
/* Read Data: Darren Powers
 * This function takes a HealthKit ObjectType, an abstract object type, which can be a SampleType or ActivityType,
 * and retrieves the related information from HealthKit
 */
        // Make sure permissions granted for specified data type
        let authorizeRead = Set(arrayLiteral: dataType)
        authorizeHealthKit(share: nil, read: authorizeRead) { (success, error) -> Void in
            if !success {
                print("Unable to get permissions")
            }
        }
        if let data = dataType as? HKSampleType { //The data coming in is sample-type data
            // Build query predicate
            let distantPast = NSDate.distantPast as NSDate
            let currentDate = NSDate()
            let lastPredicate = HKQuery.predicateForSamples(withStart: distantPast as Date, end: currentDate as Date, options: [])
            
            // Get the one most recent piece of data
            let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
            
            // Query HealthKit for the last entry
            let query = HKSampleQuery(sampleType: data, predicate: lastPredicate, limit: 1, sortDescriptors: [sortDescriptor]) {
                (sampleQuery, results, error) -> Void in
                
                // If there is an error, do not return object, return error
                if let queryError = error {
                    completion?(nil, queryError as NSError)
                    return
                 }
                
                // Set the first Sample in results as the most recent one
                let lastSample = results!.first
                if completion != nil {
                    completion(lastSample, nil) //Return the object, not an error
                }
            }
            // Execute the query generated above
            self.healthKitStore.execute(query)
            return
        } else {
            print("query \(dataType) type not currently supported")
        }
    }
}
