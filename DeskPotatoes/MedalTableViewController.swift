//
//  MedalTableViewController.swift
//  DeskPotatoes
//
//  Created by Terrell, Joshua on 11/1/18.
//  Copyright © 2018 Darren Powers. All rights reserved.
//

import UIKit

class MedalTableViewController: UITableViewController {
    
    class Medal {
        var name: String
        var unlocked: Bool
        init(name: String, unlocked: Bool){
            self.name = name
            self.unlocked = unlocked
        }
    }
    
    var medals: [Medal] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMedals()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "MedalsTableViewCell", for: indexPath)
     
     cell.textLabel?.text = "Section \(indexPath.section) Row \(indexPath.row)"
     
     // Configure the cell...
     
     return cell
     }*/
    
    
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
    
    private func loadMedals()
    {
        
        let medal1 = Medal(name: "Welcome", unlocked: false)
        //When the user opens the Medal page this will unlock
        
        let medal2 = Medal(name: "Walk a Mile in my Shoes", unlocked: false)
        //When the user exercises for the first time
        
        let medal3 = Medal(name: "Welcome part 2", unlocked: false)
        //When the user opens the Medal page again
        
        medals.append(medal1)
        medals.append(medal2)
        medals.append(medal3)
        
        print(medals.count)
        print("hello")
        
    }
    
}
