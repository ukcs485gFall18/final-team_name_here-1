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
    @IBOutlet weak var totalExerciseTime: UILabel!
    
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var bmiLabel: UILabel!
    
    @IBOutlet weak var totalDistanceToday: UILabel!
    @IBOutlet weak var totalEnergyToday: UILabel!
    
    @IBOutlet weak var totalDistance: UILabel!
    @IBOutlet weak var totalEnergy: UILabel!
    @IBOutlet weak var totalEnergyIntake: UILabel!
    
    let healthManager:HealthKitManager = HealthKitManager()

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
