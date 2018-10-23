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
    
    func authorizeHealthKit(completion:( (_ success: Bool, _ error: NSError?) -> Void )!){
        /* Authorize Health Kit: Darren Powers
         * This function performs the work of authorizing access to HealthKit
         */
        
/* TO DO: Make sure this code allows for users to approve/deny requests */
/* TO DO: Be more specific with what data will be requested than just activity summary type, if we need more. */
        
        // Specify Health Data to Read
        let healthDataToRead = Set(arrayLiteral: HKObjectType.activitySummaryType())
        // Specify Health Data to Write
        let healthDataToWrite = Set(arrayLiteral: HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)!)
        // Verify HealthKit data is available
        if !HKHealthStore.isHealthDataAvailable() {
            print("Health Kit Data Unavailable on this Device")
            return
        }
        // Actually request the authorization from HealthKit
        healthKitStore.requestAuthorization(toShare: healthDataToWrite, read: healthDataToRead) { success, error in
            guard error == nil, success else {
                print(error!)
                return
            }
        }
    }
    
    func shareData(dataType: HKQuantityTypeIdentifier, data: HKObject) {
        /* Share Data: Darren Powers
         * This function takes a HealthKit Quantity Type Identifier and a HealthKit Object as parameters
         * and does the work of saving the data appropriately to HealthKit
         */
/* TO DO: Code for Share Data */
    }
    
}
