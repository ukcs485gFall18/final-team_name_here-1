//
//  MedalTableViewController.swift
//  DeskPotatoes
//
//  Created by Terrell, Joshua on 11/1/18.
//  Copyright © 2018 Darren Powers. All rights reserved.
//

import UIKit

class MedalTableViewController: UITableViewController {

    
    
    var connectWorkoutView: WorkoutViewController = WorkoutViewController()
    var checkStatus: Int = 0
    var medals: [Medal] = []
    var med1: String = "Hello"
    var med3: String = "Hello"
    
    class Medal {
        var name: String
        var unlocked: String
        init(name: String, unlocked: String){
            self.name = name
            self.unlocked = unlocked
        }
    }
    
    @IBAction func returnButton(_ sender: Any) {
        print("I have returned")
        checkStatus = 2
        med3 = "Unlocked"
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
        
        let medal3 = Medal(name: "Welcome Back", unlocked: "Locked")
        //When the user opens the Medal page again (hits Return)
        
        let medal4 = Medal(name: "First Workout", unlocked: "Locked")
        //When the user opens up the workout tab
        
        medals.append(medal1)
        medals.append(medal2)
        medals.append(medal3)
        medals.append(medal4)
        
        med1 = medal1.unlocked
        med3 = medal3.unlocked
        
        //checkStatus = hello(x: med1)
        
        if (checkStatus == 1)
        {
            medal2.unlocked = "Unlocked"
        }
        else if (checkStatus == 2)
        {
            medal3.unlocked = "Unlocked"
        }
        else
        {
            medal2.unlocked = "Locked"
            medal3.unlocked = "Locked"
        }
    }
    
    public func hello(x: String) -> Int{
        
        print(med1)
        
        return 0
        
    }
    

    
}
/* 1. Create a medal that unlocks when you use the return button
 2. Create a medal that unlocks when you hit the workout button
 3. Create a medal that unlocks when you run, walk, etc
 4. Create a medal that unlocks when you add a picture*/
