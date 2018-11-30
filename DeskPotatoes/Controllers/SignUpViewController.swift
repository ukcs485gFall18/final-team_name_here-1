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
    @IBOutlet weak var TextFieldFirstName: UITextField!
    @IBOutlet weak var TextFieldLastName: UITextField!
    @IBOutlet weak var TextFieldEmail: UITextField!
    @IBOutlet weak var TextFieldPassword: UITextField!

    
    let BASE_URL = "https://final-project-b62cd.firebaseio.com/"
    // reference from: https://stackoverflow.com/questions/37330220/cannot-call-value-of-non-function-type-modulefirebase
    var firebase = Database.database().reference()
    
    @IBAction func register(_ sender: AnyObject) {
        let email = TextFieldEmail.text
        let password = TextFieldPassword.text
        
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
        
        //initialising firebase
        FirebaseApp.configure()
        
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
