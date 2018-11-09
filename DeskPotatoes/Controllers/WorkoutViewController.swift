//
//  WorkoutViewController.swift
//  DeskPotatoes
//
//  Created by Siyuan Chen on 10/18/18.
//  Copyright © 2018 Darren Powers. All rights reserved.
//

import HealthKit
import UIKit
import CoreLocation

class WorkoutViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var mph: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var calorie: UILabel!
    
    @IBOutlet weak var walkButton: UIButton!
    @IBOutlet weak var runButton: UIButton!
    @IBOutlet weak var rideButton: UIButton!
    
    let WALKING = 0; // User clicks Walking Button
    let RUNNING = 1; // User clicks Running Button
    let RIDING = 2;  // User clicks Riding Button
    var selectedMode = 0; // Records which button is clicked
    
    let healthManager:HealthKitManager = HealthKitManager()
    
    var zeroTime = TimeInterval()
    var timer : Timer = Timer()
    
    // Distance parts
    let locationManager = CLLocationManager()
    var startLocation: CLLocation!
    var lastLocation: CLLocation!
    var distanceTraveled = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization();
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }
        else {
            print("Location service disabled");
        }
        
        // We cannot access the user's HealthKit data without specific permission.
        if #available(iOS 9.3, *) {
            getHealthKitPermission()
        } else {
            // Fallback on earlier versions
        }

        // Do any additional setup after loading the view.
    }
    
    @available(iOS 9.3, *)
    func getHealthKitPermission() {
        
        // Seek authorization in HealthKitManager.swift.
        healthKitManager.authorizeHealthKit { share: nil, read: nil, (authorized, error) -> Void in
            if authorized {
                // Do something
                
            } else {
                if error != nil {
                    print(error!)
                }
                print("Permission denied.")
            }
        }
    }
    
    /* Get current position
     * Without startLocation, data will be stored in startLocation
     * Otherwise, data will be stored in lastLocation
     */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if startLocation == nil {
            startLocation = locations.first
        } else {
            let lastDistance = lastLocation.distance(from: locations.last as! CLLocation)
            distanceTraveled += lastDistance * 0.000621371
            
            let trimmedDistance = String(format: "%.2f", distanceTraveled)
            
            time.text = trimmedDistance
        }
        
        lastLocation = locations.last
    }
    
    @objc func updateTime() {
        let currentTime = NSDate.timeIntervalSinceReferenceDate
        var timePassed: TimeInterval = currentTime - zeroTime
        let minutes = UInt8(timePassed / 60.0)
        timePassed -= (TimeInterval(minutes) * 60)
        let seconds = UInt8(timePassed)
        timePassed -= TimeInterval(seconds)
        let millisecsX10 = UInt8(timePassed * 100)
        
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        let strMSX10 = String(format: "%02d", millisecsX10)
        
        time.text = "\(strMinutes):\(strSeconds):\(strMSX10)"
        
        if time.text == "60:00:00" {
            timer.invalidate()
            locationManager.stopUpdatingLocation()
        }
    }
    
    @IBAction func startTimer(_ sender: AnyObject) {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(WorkoutViewController.updateTime), userInfo: nil, repeats: true)
        zeroTime = NSDate.timeIntervalSinceReferenceDate
        
        distanceTraveled = 0.0
        startLocation = nil
        lastLocation = nil
        
        locationManager.startUpdatingLocation()
    }
    
    @IBAction func stopTimer(_ sender: AnyObject) {
        timer.invalidate()
        locationManager.stopUpdatingLocation()
    }
    
    @IBAction func share(_ sender: AnyObject) {
        switch selectedMode {
        case WALKING:
            <#code#>healthKitManager.shareDate(dataType: HKQuantityTypeIdentifier.distanceWalkingRunning，value: distanceTraveled, date: NSDate(), completion:((HKSample?, error) -> Void)!)
        case RUNNING:
            <#code#>healthKitManager.shareDate(HKQuantityTypeIdentifier.distanceWalkingRunning, value: distanceTraveled, date: NSDate())
        case RIDING:
            <#code#>healthKitManager.shareDate(HKQuantityTypeIdentifier.distanceCycling, value: distanceTraveled, date: NSDate())
        default:
            <#code#>healthKitManager.shareDate(dataType: HKQuantityTypeIdentifier.distanceWalkingRunning，value: distanceTraveled, date: NSDate())
        }
    }
    
    /* Set three different situations for each button
     * When one is pressed, it will turn blue and others will be default(white)
     */
    @IBAction func chooseToWalk(_ sender: UIButton) {
        walkButton.setTitleColor(UIColor.blue, for: .normal) // set selected button color to blue
        runButton.setTitleColor(UIColor.white, for: .normal) // set the other button color to default
        rideButton.setTitleColor(UIColor.white, for: .normal) // set the other button color to default
        selectedMode = WALKING;
    }
    
    @IBAction func chooseToRun(_ sender: UIButton) {
        walkButton.setTitleColor(UIColor.white, for: .normal)
        runButton.setTitleColor(UIColor.blue, for: .normal)
        rideButton.setTitleColor(UIColor.white, for: .normal)
        selectedMode = RUNNING;
    }
    
    @IBAction func chooseToCycle(_ sender: UIButton) {
        walkButton.setTitleColor(UIColor.white, for: .normal)
        runButton.setTitleColor(UIColor.white, for: .normal)
        rideButton.setTitleColor(UIColor.blue, for: .normal)
        selectedMode = RIDING;
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
