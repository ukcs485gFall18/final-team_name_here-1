//
//  SignUpViewController.swift
//  DeskPotatoes
//
//  Created by Siyuan Chen on 10/28/18.
//  Copyright © 2018 Darren Powers. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!

    // let BASE_URL = "https://final-project-b62cd.firebaseio.com/"
    var firebase = Database.database().reference()
    
    @IBAction func register(_ sender: AnyObject) {
        let email = self.email.text
        let password = self.password.text
        
        Auth.auth().createUser(withEmail: email!, password: password!, completion: { (user, error) in
            if error == nil {
                //registration successful
                print("nice job!")
            }else{
                //registration failure
                print("failed registration")
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
