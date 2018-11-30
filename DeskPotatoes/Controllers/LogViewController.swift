//
//  LogViewController.swift
//  DeskPotatoes
//
//  Created by Siyuan Chen on 10/28/18.
//  Copyright © 2018 Darren Powers. All rights reserved.
//

import UIKit
import Firebase

class LogViewController: UIViewController {
    @IBOutlet weak var TextFieldUsername: UITextField!
    @IBOutlet weak var TextFieldPassword: UITextField!
    @IBOutlet weak var LabelStatus: UILabel!
    
    @IBAction func login(_ sender: Any) {
        if let email = self.TextFieldUsername.text, let password = self.TextFieldPassword.text{
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                // ...
            }
        } else {
            LabelStatus.text = "email/password can't be empty"
        }
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
