//
//  LogViewController.swift
//  DeskPotatoes
//
//  Created by Siyuan Chen on 10/28/18.
//  Copyright © 2018 Darren Powers. All rights reserved.
//  Coded by Siyuan Chen unless otherwise noted

import UIKit
import Firebase

class LogViewController: UIViewController {
    @IBOutlet weak var TextFieldUsername: UITextField!
    @IBOutlet weak var TextFieldPassword: UITextField!
    @IBOutlet weak var LabelStatus: UILabel!
    
    
    
    @IBAction func login(_ sender: Any) {
        if let email = self.TextFieldUsername.text, let password = self.TextFieldPassword.text{
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if (user != nil) {
                    print("user: \(String(describing: user))")
                    self.performSegue(withIdentifier: "loginSegue", sender: self) //Segue added by Darren Powers
                } else{
                    print("Email/password incorrect!")
                }
            }
        } else {
            LabelStatus.text = "email/password can't be empty"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TextFieldPassword.isSecureTextEntry = true;
        // Do any additional setup after loading the view.
        if (Auth.auth().currentUser != nil) {
            self.performSegue(withIdentifier: "loginSegue", sender: self)
        }
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
