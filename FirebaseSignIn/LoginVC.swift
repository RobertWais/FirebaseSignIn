//
//  LoginVC.swift
//  FirebaseSignIn
//
//  Created by Robert Wais on 2/28/18.
//  Copyright © 2018 Robert Wais. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBAction func signInBtnPressed(_ sender: Any) {
        if emailField.text != nil && passwordField.text != nil{
            AuthService.instance.loginUser(email: emailField.text!, password: passwordField.text!, complete: { (success, error, im)  in
                if success {
                    print("User Accepted")
                    self.imageView.image = im
                }else{
                    print("NO")
                    print(String(describing: error?.localizedDescription))
                }
            })
            /*
            AuthService.instance.registerUser(email: emailField.text!, password: passwordField.text!, complete: { (success, error) in
                if success {
                    print("User Accepted")
                }else{
                    print("NO")
                    print(String(describing: error?.localizedDescription))
                }
            })
 */
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
