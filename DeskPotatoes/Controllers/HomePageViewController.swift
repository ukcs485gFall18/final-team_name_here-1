//
//  HomePageViewController.swift
//  DeskPotatoes
//
//  Created by Siyuan Chen on 10/29/18.
//  Copyright © 2018 Darren Powers. All rights reserved.
//

/* Some of the formatting etc. should be offloaded into a model rather than being
 * handled here in the the controller.
 * Also, this should be the page where a user can access their community profile
 * and options.
 */

import UIKit
import HealthKit
import Firebase

class HomePageViewController: UIViewController {
    @IBOutlet weak var totalExerciseTime: UILabel!
    
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var bmiLabel: UILabel!
    
    @IBOutlet weak var totalDistanceToday: UILabel!
    @IBOutlet weak var totalEnergyToday: UILabel!
    
    @IBOutlet weak var totalDistance: UILabel!
    @IBOutlet weak var totalEnergy: UILabel!
    

    //profile button calls profile view as modal
    
    //need to add image to logout button
    @IBAction func logOut(_ sender: UIButton) {
        // Work to log out from the firebase needs to go here.
        // After logged out, should segue back to login page.
        let logoutConfirm = UIAlertController(title: "Log Out?", message: "Are you sure you want to log out?", preferredStyle: .alert)
        logoutConfirm.addAction(UIAlertAction(title:"Cancel", style: .default, handler: {
            [weak logoutConfirm] (_) in
            print("Cancelled logout")
        }))
        logoutConfirm.addAction(UIAlertAction(title: "Log out",style: .default, handler: { [weak logoutConfirm] (_) in
            try! Auth.auth().signOut()
            print("loggedout")
            self.performSegue(withIdentifier: "logoutSegue", sender: self)
        }))
        self.present(logoutConfirm, animated: true, completion: nil)
    }
    
    let healthManager:HealthKitManager = HealthKitManager()
    let healthModel: HealthModel = HealthModel()
    let workoutStorage = WorkoutStorage()
    var height: HKQuantitySample?
    var heightM: Double = 0.0
    var weight: HKQuantitySample?
    var weightKG: Double = 0.0
    
    //To handle asynchronous functions
    let dispatchGroup = DispatchGroup()
    
    func setHeight(){
        self.healthManager.readData(dataType: HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!) { (sample, error) in
            
            let height:HKQuantitySample? = sample as? HKQuantitySample
            if let meters = height?.quantity.doubleValue(for: HKUnit.meter()) {
                self.heightM = meters as Double
                print("It worked: \(self.heightM)")
                let formatHeight = LengthFormatter()
                formatHeight.isForPersonHeightUse = true
                DispatchQueue.main.async{
                    self.heightLabel.text = formatHeight.string(fromMeters: meters)
                    self.dispatchGroup.leave()
                }
                
            }
        }
    }
    
    func setWeight(){
        self.healthManager.readData(dataType: HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!) { (sample, error) in
            
            let weight:HKQuantitySample? = sample as? HKQuantitySample
            if let kilos = weight?.quantity.doubleValue(for: HKUnit.gramUnit(with: .kilo)) {
                let formatWeight = MassFormatter()
                formatWeight.isForPersonMassUse = true
                DispatchQueue.main.async{
                    self.weightLabel.text = formatWeight.string(fromKilograms: kilos)
                    self.weightKG = kilos as Double
                    print("It worked: \(self.weightKG)")
                    self.dispatchGroup.leave()
                }
                
            }
        }
    }
    
    func setBMI(){
        dispatchGroup.enter()
        setHeight()
        print("After Set Height: \(self.heightM)")
        dispatchGroup.enter()
        setWeight()
        print("After Set Weight: \(self.weightKG)")
        dispatchGroup.notify(queue: .main) {
            let bodyMassIndex = self.healthManager.calculateBMI(height: self.heightM, weight: self.weightKG)
            var rangeString: String
            //Body Mass Index Ranges from Wikipedia using following source provided by article author: "BMI Classification". Global Database on Body Mass Index. World Health Organization. 2006. Archived from the original on April 18, 2009. Retrieved July 27, 2012"
            if (bodyMassIndex < 18.5){
                rangeString = "Underweight"
            } else if (bodyMassIndex >= 18.5 && bodyMassIndex < 25.0){
                rangeString = "Normal"
            } else if (bodyMassIndex >= 25.0 && bodyMassIndex < 30.0) {
                rangeString = "Overweight"
            } else if (bodyMassIndex >= 30) {
                rangeString = "Obese"
            } else {
                rangeString = ""
            }
            self.bmiLabel.text = (bodyMassIndex != 0.0) ? "\(String(format:"%.2f", bodyMassIndex )) [\(rangeString)]" : "N/A"
            //self.bmiLabel.text = String(bodyMassIndex)
        }
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
            if (userActiveEnergyBurned != nil) {
                self.workoutStorage.currentEnergyBurned = (userActiveEnergyBurned as! Double)
                self.workoutStorage.totalEnergyBurned += (userActiveEnergyBurned as! Double)
                
                self.totalEnergy.text = "\(String(self.workoutStorage.totalEnergyBurned)) cal"
            }
            var activeEnergyBurnedString = "No Active Energy Burned"
            
            if (userAEBGoal != nil) {
                activeEnergyBurnedString = "\(String(describing: userActiveEnergyBurned!)) cal"
            }
            
            DispatchQueue.main.async {
                self.totalEnergyToday.text = activeEnergyBurnedString
            }
        })
    }
    
    /*func setDistanceAndTime(){
        self.distanceLabel.text = "\(String(describing: self.workoutStorage.currentDistance))"
        self.totalDistanceLabel.text = "\(self.workoutStorage.totalDistance)"
        self.totalTimeLabel.text = "\(self.workoutStorage.totalTime)"
    }*/
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.healthModel.authorizeHomepageElements()
        setBMI()
        setEnergy()
        //setDistanceAndTime()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
