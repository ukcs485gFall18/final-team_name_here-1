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
    var ref : DatabaseReference?

    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func register(_ sender: AnyObject) {
    ref = Database.database().reference()
//        let email = self.email.text
//        let password = self.password.text
//
//        Auth.auth().createUser(withEmail: email!, password: password!, completion: { (user, error) in
//            if error == nil {
//                //registration successful
//                print("nice job!")
//            }else{
//                //registration failure
//                print("failed registration")
//            }
//        })
        
        // Reference: https://github.com/firebase/quickstart-ios/blob/904fbc06bd69363782314a9d027f6300d054c1b3/authentication/AuthenticationExampleSwift/EmailViewController.swift#L113-L125
        if let email = self.email.text {
                if let password = self.password.text {
                        // [START create_user]
                        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
                            // [START_EXCLUDE]
                            guard let email = authResult?.user.email, error == nil else {
                                print("Error with email")
                                return
                            }
                            print(Auth.auth().currentUser?.uid as Any)
                            let newUser:[String: AnyObject] = [
                                "uid": Auth.auth().currentUser?.uid as AnyObject,
                                "email": self.email.text! as AnyObject,
                                "totalMinute" : 0 as AnyObject,
                                "lastDistance" : 0 as AnyObject,
                                "totalDistance" : 0 as AnyObject,
                                "lastEnergyBurned" : 0 as AnyObject,
                                "totalEnergyBurned" : 0 as AnyObject
                            ]
                            if (Auth.auth().currentUser?.uid != nil){
                                self.ref?.child("users").child((Auth.auth().currentUser?.uid)!).setValue(newUser)
                            }
                            print("\(email) created")
                            // self.navigationController!.popViewController(animated: true)
                            // [END_EXCLUDE]
                            guard (authResult?.user) != nil else { return }
                        }
                        // [END create_user]
                }else {
                    print("Password can't be empty")
                }
        } else {
            print("email can't be empty")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        password.isSecureTextEntry = true;
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
