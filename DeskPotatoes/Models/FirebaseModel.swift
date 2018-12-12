//
//  FirebaseModel.swift
//  DeskPotatoes
//
//  Created by Darren Powers on 10/12/2018.
//  Copyright © 2018 Darren Powers. All rights reserved.
//  Coded by Darren Powers unless otherwise noted

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
    
    let group = DispatchGroup()
    func readWorkouts(uid: String, completion: @escaping ([Workout])->Void)  {
        var workouts: [Workout] = []
        var firstname: String = ""
        var lastname: String = ""
        self.group.enter()
        self.getUsername(uid: uid){  (first, last) in
            print("\(first) \(last)")
            firstname.append(first)
            lastname.append(last)
            //group.leave()
        }
        self.group.enter()
        DispatchQueue.global(qos: .default).async {
            
            
            self.ref?.child("workouts").child(uid).observe(.value) { (datasnapshot) in
                guard let workoutsnapshot = datasnapshot.children.allObjects as? [DataSnapshot] else {return}
                for workout in workoutsnapshot {
                    //print(workout)
                    
                    let newWorkout:Workout = Workout(firstName: firstname, lastName: lastname, time: workout.childSnapshot(forPath: "time").value as! String, type: workout.childSnapshot(forPath: "workoutType").value as! String, Value: workout.childSnapshot(forPath:"distance").value as! Double)

                    workouts.append(newWorkout)
                }
            }
            self.group.leave()
        }
        self.group.notify(queue: .main) {
            completion(workouts)
        }
        
    }
    
    func getUsername(uid: String, completion: @escaping (String, String) -> Void) {
        var firstName: String = ""
        var lastName: String = ""
        DispatchQueue.global(qos: .default).async {
            self.ref!.child("users").observe(.value) { (datasnapshot) in
                guard let usersnapshot = datasnapshot.children.allObjects as? [DataSnapshot] else {return}
                for user in usersnapshot {
                    if (user.key == uid){
                        firstName.append( user.childSnapshot(forPath: "firstname").value as? String ?? "User")
                        lastName.append( user.childSnapshot(forPath: "lastname").value as? String ?? "User")
                    }
                }
                
            }
            self.group.leave()
        }
        self.group.notify(queue: .main) {
            completion(firstName, lastName)
        }
    }
}

class Workout {
    var userFirstName: String
    var userLastName: String
    var time: String
    var type: String
    var value: Double
    init (firstName: String, lastName: String, time: String, type: String, Value: Double) {
        self.userFirstName = firstName
        self.userLastName = lastName
        self.time = time
        self.type = type
        self.value = Value
    }
}
