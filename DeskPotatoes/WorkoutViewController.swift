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
    
    let WALKING = 0; // User clicks Walking Button
    let RUNNING = 1; // User clicks Running Button
    let RIDING = 2;  // User clicks Riding Button
    var selectedMode = 0; // Records which button is clicked
    
    var zeroTime = TimeInterval()
    var timer : Timer = Timer()
    
    // Distance parts
    let locationManager = CLLocationManager()
    var startLocation: CLLocation!
    var lastLocation: CLLocation!
    var distanceTraveled = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
