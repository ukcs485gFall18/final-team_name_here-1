//
//  HealthModel.swift
//  DeskPotatoes
//
//  Created by Darren Powers on 10/12/2018.
//  Copyright © 2018 Darren Powers. All rights reserved.
//  Coded by Darren Powers unless otherwise noted


/* HealthModel
 * this handles work for prepping information to be displayed by the
 * View Controllers
 */

import Foundation
import UIKit
import HealthKit

class HealthModel {
    let healthManager: HealthKitManager = HealthKitManager()
    
    func authorizeHomepageElements() {
        let reader: Set = [HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height), HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass), HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned), HKObjectType.activitySummaryType()]
        self.healthManager.authorizeHealthKit(share: nil, read: (reader as! Set<HKObjectType>)) { (auth, error) in
            if ((error) != nil) {
                print("unable to authorize: \(String(describing: error))")
            } else {
                print("healthkit authorized for homepage elements")
            }
        }
    }
    

}

