//
//  FirebaseModel.swift
//  DeskPotatoes
//
//  Created by Darren Powers on 10/12/2018.
//  Copyright © 2018 Darren Powers. All rights reserved.
//

/* this class should hold methods to do work pertaining to
 * reading from and writing to the firebase database.
 */
import Foundation
import Firebase

class FirebaseModel {
    
    let ref: DatabaseReference? = Database.database().reference()
    
    func postWorkout(workoutType: String, value: Double) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let workout: [String : Any] = [
            "workoutType": workoutType,
            "distance": value,
            "time": formatter.string(from: Date())
        ]
        
        if (Auth.auth().currentUser?.uid != nil){
            self.ref?.child("workouts").child((Auth.auth().currentUser?.uid)!).child(formatter.string(from: Date())).setValue(workout)
        }
    }
    func readWorkouts(uid: String) -> [[String: Any]] {
        var workouts: [[String:Any]] = []
        
        ref!.child("workouts").child((Auth.auth().currentUser?.uid)!).observe(.value) { (datasnapshot) in
            guard let workoutsnapshot = datasnapshot.children.allObjects as? [DataSnapshot] else {return}
            for workout in workoutsnapshot {
                print(workout)
                let newWorkout:[String:Any] = [
                    "workoutType": workout.childSnapshot(forPath: "workoutType").value as! String,
                    "distance": workout.childSnapshot(forPath:"distance").value as! Double,
                    "time": workout.childSnapshot(forPath:"time").value as! String
                ]
                workouts.append(newWorkout)
            }
        }
        return workouts
    }
}
