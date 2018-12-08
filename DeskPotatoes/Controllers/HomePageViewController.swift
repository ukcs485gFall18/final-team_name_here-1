//
//  HomePageViewController.swift
//  DeskPotatoes
//
//  Created by Siyuan Chen on 10/29/18.
//  Copyright © 2018 Darren Powers. All rights reserved.
//

import UIKit
import HealthKit

class HomePageViewController: UIViewController {
    @IBOutlet weak var totalTimeLabel: UILabel!
    
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var bmiLabel: UILabel!
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var energyLabel: UILabel!
    
    @IBOutlet weak var totalDistanceLabel: UILabel!
    @IBOutlet weak var totalEnergyLabel: UILabel!
    
    let healthManager:HealthKitManager = HealthKitManager()
    let workoutStorage = WorkoutStorage()
    var height: HKQuantitySample?
    var weight: HKQuantitySample?
    var meterForBMI: Double?
    var kilogramForBMI: Double?

    
    func setHeight(){
        let heightSample = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)
        
        self.healthManager.readData(dataType: heightSample!, completion: { (userHeight, error) -> Void in
            
            if( error != nil ) {
                print("Error: \(String(describing: error?.localizedDescription))")
                return
            }
            
            var heightString = ""
            self.height = userHeight as? HKQuantitySample
            
            // The height is formatted to the user's locale.
            if let meters = self.height?.quantity.doubleValue(for: HKUnit.meter()) {
                self.meterForBMI = meters
                let formatHeight = LengthFormatter()
                formatHeight.isForPersonHeightUse = true
                heightString = formatHeight.string(fromMeters: meters)
            }
            
            DispatchQueue.global(qos: .userInitiated).async{
                DispatchQueue.main.async {
                    self.heightLabel.text = heightString
                }
            }
        })
    }
    
    func setWeight(){
        let weightSample = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)
        
        self.healthManager.readData(dataType: weightSample!, completion: { (userWeight, error) -> Void in
            
            if( error != nil ) {
                print("Error: \(String(describing: error?.localizedDescription))")
                return
            }
            
            var weightString = ""
            self.weight = userWeight as? HKQuantitySample
            
            // The weight is formatted to the user's locale.
            if let kilograms = self.weight?.quantity.doubleValue(for: HKUnit.gramUnit(with: .kilo)) {
                self.kilogramForBMI = kilograms
                let formatWeight = MassFormatter()
                formatWeight.isForPersonMassUse = true
                weightString = formatWeight.string(fromKilograms : kilograms)
            }
            
            DispatchQueue.global(qos: .userInitiated).async{
                DispatchQueue.main.async {
                    self.heightLabel.text = weightString
                }
            }
        })
    }
    
    func setBMI(){
        var bodyMassIndex: Double? {
            return Double(kilogramForBMI!/(meterForBMI!*meterForBMI!))
        }
        
        self.bmiLabel.text = String(format:"%.2f", bodyMassIndex!)
    }
    
    func setEnergy(){
        //Refer from last project and adjusted by Siyuan Chen
        /* @desc: Get data on Energy Burned Goal from HealthKit
         * @author: Darren Powers
         * Notes: based on code for setHeight below and includes information gathered from: https://crunchybagel.com/accessing-activity-rings-data-from-healthkit/
         */
        
        // Call HealthKitManager's getSample() method to get active energy for today from HealthKit
        self.healthManager.getEnergyBurned(completion: { (userActiveEnergyBurned, userAEBGoal, error) -> Void in
            
            if( error != nil) {
                print("Error: \(String(describing: error?.localizedDescription))")
                return
            }
            
            self.workoutStorage.currentEnergyBurned = (userActiveEnergyBurned as! Double)
            self.workoutStorage.totalEnergyBurned += (userActiveEnergyBurned as! Double)
            
            self.totalEnergyLabel.text = "\(String(self.workoutStorage.totalEnergyBurned)) cal"
            
            var activeEnergyBurnedString = ""
            
            if (userAEBGoal != nil) {
                activeEnergyBurnedString = "\(String(describing: userActiveEnergyBurned!)) cal"
            }
            
            DispatchQueue.global(qos: .userInitiated).async{
                DispatchQueue.main.async {
                    self.energyLabel.text = activeEnergyBurnedString
                }
            }
        })
    }
    
    func setDistanceAndTime(){
        self.distanceLabel.text = "\(String(describing: self.workoutStorage.currentDistance))"
        self.totalDistanceLabel.text = "\(self.workoutStorage.totalDistance)"
        self.totalTimeLabel.text = "\(self.workoutStorage.totalTime)"
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        healthManager.readData(dataType: HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!) { (sample, error) in
            print("It worked")
            let height:HKQuantitySample? = sample as? HKQuantitySample
            if let meters = height?.quantity.doubleValue(for: HKUnit.meter()) {
                let formatHeight = LengthFormatter()
                formatHeight.isForPersonHeightUse = true
                DispatchQueue.main.async{
                    self.heightLabel.text = formatHeight.string(fromMeters: meters)
                }
                
            }
        }

        setHeight()
        setWeight()
        setBMI()
        setEnergy()
        setDistanceAndTime()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
