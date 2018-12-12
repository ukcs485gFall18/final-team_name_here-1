//
//  CommunityViewController.swift
//  DeskPotatoes
//
//  Created by Siyuan Chen on 10/18/18.
//  Copyright © 2018 Darren Powers. All rights reserved.
//  Coded by Darren Powers unless otherwise noted

/* This view controller should access the user's community information from the database,
 * and allow them to post a 'moment' that they can access.
 * profile information should be accessable/editable from the 'home' page using
 * 'HomePageViewController.swift'
 * -Darren
 */

import UIKit
import Firebase

class CommunityViewController: UIViewController {

    @IBAction func ReloadPosts(_ sender: UIButton) {
        self.workoutsTable.reloadData()
    }
    @IBOutlet weak var workoutsTable: UITableView!
    var workouts: [Workout] = []
    var firebaseModel: FirebaseModel = FirebaseModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        workoutsTable.delegate = self
        workoutsTable.dataSource = self
        
        // get all of the logged in user's workouts
        
        firebaseModel.readWorkouts(uid: Auth.auth().currentUser?.uid ?? "") {
            work in
            self.workouts = work
            self.workoutsTable.reloadData()
        }
        
        // Do any additional setup after loading the view.
        
    }
    
    
    
    
}

extension CommunityViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTable(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workouts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellWorkout: WorkoutTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "workoutMoment", for: indexPath) as? WorkoutTableViewCell
        if let cell = cellWorkout {
            
            cell.typeLabel?.text = workouts[indexPath.row].type as String
            cell.dateLabel?.text = workouts[indexPath.row].time as String
            cell.valueLabel?.text = String(format: "%f", workouts[indexPath.row].value)
            cell.nameLabel?.text = "\(workouts[indexPath.row].userFirstName as String) \(workouts[indexPath.row].userLastName as String)"
            return cell
        }
        
        return cellWorkout!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95.0
    }
}
