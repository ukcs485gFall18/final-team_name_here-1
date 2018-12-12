//
//  MedalTableViewController.swift
//  DeskPotatoes
//
//  Created by Terrell, Joshua on 11/1/18.
//  Copyright © 2018 Darren Powers. All rights reserved.
// Coded by Joshua Terrell unless otherwise noted

import UIKit
import Firebase

class MedalTableViewController: UITableViewController {

    @IBAction func Dismiss(_ sender: UIButton) {
        dismiss(animated:true, completion: nil)
    }
    
    //Connects the variables from the workout view controller
    var connectWorkoutView: WorkoutViewController = WorkoutViewController()
    
    var checkStatus: Int = 0
    var medals: [Medal] = []
    var med1: String = "Unlocked"
    
    var refMedals: DatabaseReference! = Database.database().reference()
    var medalHandler: DatabaseHandle!
    
    //Class of Medals for the application
    class Medal {
        var name: String
        var unlocked: String
        init(name: String, unlocked: String){
            self.name = name
            self.unlocked = unlocked
        }
    }
    
    @IBAction func returnButton(_ sender: Any) {
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMedals()

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
        let medal1 = Medal(name: "Welcome", unlocked: "Unlocked")
        //When the user opens the Medal page this will unlock
        
        let medal2 = Medal(name: "Walk a Mile in my Shoes", unlocked: "Locked")
        //When the user walks a mile
        
        let medal3 = Medal(name: "Walk it Out", unlocked: "Locked")
        //When the user clicks on the walk option
        
        let medal4 = Medal(name: "First Workout", unlocked: "Locked")
        //When the user opens up the workout tab
        
        let medal5 = Medal(name: "Walk a Mile in my Shoes: Bronze", unlocked: "Locked")
        //When the user walks for longer
        
        let medal6 = Medal(name: "Walk a Mile in my Shoes: Silver", unlocked: "Locked")
        //When the user walks for longer
        
        let medal7 = Medal(name: "Walk a Mile in my Shoes: Gold", unlocked: "Locked")
        //When the user walks for longer
        
        medals.append(medal1)
        medals.append(medal2)
        medals.append(medal5)
        medals.append(medal6)
        medals.append(medal7)
        medals.append(medal3)
        medals.append(medal4)
        
        //connectWorkoutView.distanceTraveled = 1.1
        
        //Conditions to see if the medal should be unlocked or not
        if(connectWorkoutView.distanceTraveled >= 1.0)
        {
            medal2.unlocked = "Unlocked"
        }
        
        if (medal2.unlocked == "Unlocked" || medal3.unlocked == "Unlocked")
        {
            medal4.unlocked = "Unlocked"
        }
        
        if(connectWorkoutView.distanceTraveled >= 5.0)
        {
            medal5.unlocked = "Unlocked"
        }
        
        if(connectWorkoutView.distanceTraveled >= 10.0)
        {
            medal6.unlocked = "Unlocked"
        }
        
        if(connectWorkoutView.distanceTraveled >= 20.0)
        {
            medal7.unlocked = "Unlocked"
        }
        
        /*if (connectWorkoutView.walkButton.currentTitleColor == UIColor.blue) {
            medal3.unlocked = "Unlocked"
        }*/
        
        
        //Save the medal values in the database
        for i in 0...6 {
            refMedals.child(medals[i].name).childByAutoId().setValue(medals[i].unlocked)
        }
        
        //Reads the data from the saved medal values and puts it in the proper place
        for i in 0...6 {
            medalHandler = refMedals.child(medals[i].name).observe(.childAdded, with: {(data) in
                self.medals[i].unlocked = (data.value as? String)!
                debugPrint(self.medals[i].unlocked)
            })
        }
    }
}
