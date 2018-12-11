//
//  MedalTableViewController.swift
//  DeskPotatoes
//
//  Created by Terrell, Joshua on 11/1/18.
//  Copyright © 2018 Darren Powers. All rights reserved.
//

import UIKit
import Firebase

class MedalTableViewController: UITableViewController {

    @IBAction func Dismiss(_ sender: UIButton) {
        dismiss(animated:true, completion: nil)
    }
    
    var connectWorkoutView: WorkoutViewController = WorkoutViewController()
    var checkStatus: Int = 0
    var medals: [Medal] = []
    var med1: String = "Hello"
    var med3: String = " "

    
    var refMedals: DatabaseReference! = Database.database().reference()
    var medalHandler: DatabaseHandle!
    //refMedals = Database.database().reference()
    private var medalStorage = Storage()
    
    class Medal {
        var name: String
        var unlocked: String
        init(name: String, unlocked: String){
            self.name = name
            self.unlocked = unlocked
        }
    }
    
    @IBAction func returnButton(_ sender: Any) {
    
        checkStatus = 2
        med3 = "Unlocked"
        //call function
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMedals()

        
        /*refMedals.child("Medal").childByAutoId().setValue("Unlocked")
        
        medalHandler = refMedals.child("Medal").observe(.childAdded, with: {(data) in
            let name : String = (data.value as? String)!
            debugPrint(name)
        })
        
        medalHandler = refMedals.child("Medal").observe(.childAdded, with: {(data) in
            let name = self.medals
            debugPrint(name)
        })*/
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return medals.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cellIdentifier = "MedalsTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MedalsTableViewCell else {
            fatalError("Error cell is not an instance of the view cell")
        }
        
        let medal = medals[indexPath.row]
        
        //cell.textLabel?.text = "Section \(indexPath.section) Row \(indexPath.row)"
        
        cell.medal1.text = medal.name
        cell.medal1des.text = medal.unlocked
        

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    public func loadMedals()
    {
        
        //print(connectWorkoutView.WALKING)
        
        print(checkStatus)
        
        let medal1 = Medal(name: "Welcome", unlocked: "Unlocked")
        //When the user opens the Medal page this will unlock
        
        let medal2 = Medal(name: "Walk a Mile in my Shoes", unlocked: "Locked")
        //When the user walks a mile
        
        let medal3 = Medal(name: "Walk it Out", unlocked: "Locked")
        //When the user clicks on the walk option
        
        let medal4 = Medal(name: "First Workout", unlocked: "Locked")
        //When the user opens up the workout tab
        
        medals.append(medal1)
        medals.append(medal2)
        medals.append(medal3)
        medals.append(medal4)
        
        med1 = medal1.unlocked
        
        
        //checkStatus = hello(x: med1)
        connectWorkoutView.distanceTraveled = 1.1
        
        if(connectWorkoutView.distanceTraveled >= 1.0)
        {
            medal2.unlocked = "Unlocked"
        }
        
        if (medal2.unlocked == "Unlocked" || medal3.unlocked == "Unlocked")
        {
            medal4.unlocked = "Unlocked"
        }
        
        /*if (connectWorkoutView.walkButton.currentTitleColor == UIColor.blue) {
            medal3.unlocked = "Unlocked"
        }*/
        
        //Save the medal values
        refMedals.child(medal1.name).childByAutoId().setValue(medal1.unlocked)
        refMedals.child(medal2.name).childByAutoId().setValue(medal2.unlocked)
        refMedals.child(medal3.name).childByAutoId().setValue(medal3.unlocked)
        refMedals.child(medal4.name).childByAutoId().setValue(medal4.unlocked)

        //Reads the data from the saved medal values and puts it in the proper place
        medalHandler = refMedals.child(medal1.name).observe(.childAdded, with: {(data) in
            medal1.unlocked = (data.value as? String)!
            debugPrint(medal1.unlocked)
        })
        
        medalHandler = refMedals.child(medal2.name).observe(.childAdded, with: {(data) in
            medal2.unlocked = (data.value as? String)!
            debugPrint(medal2.unlocked)
        })
        
        medalHandler = refMedals.child(medal3.name).observe(.childAdded, with: {(data) in
            medal3.unlocked = (data.value as? String)!
            debugPrint(medal3.unlocked)
        })
        
        medalHandler = refMedals.child(medal4.name).observe(.childAdded, with: {(data) in
            medal4.unlocked = (data.value as? String)!
            debugPrint(medal4.unlocked)
        })
        
    }
    
    
    public func hello(x: String) -> Int{
        
        //print(med1)
        
        return 0
        
    }
    

    
}
/*
 2. Create a medal that unlocks when you hit the workout button
 3. Create a medal that unlocks when you run, walk, etc
 4. Create a medal that unlocks when you add a picture
 */
