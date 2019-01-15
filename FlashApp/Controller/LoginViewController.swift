//
//  LoginViewController.swift
//  FlashApp
//
//  Created by Daniel Garofalo on 1/4/19.
//  Copyright © 2019 Daniel Garofalo. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class LoginViewController: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    //MARK:- Properties
    
    //MARK:- LoadUp Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK:- Buttons
    @IBAction func logInWhenPressed(_ sender: UIButton) {
        
        SVProgressHUD.show()
        
        guard let typedEmail = emailTextField.text else { return }
        guard let typedPassword = passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: typedEmail, password: typedPassword) { (result, error) in
            
            if error == nil {
                print("Login successful")
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: GO_TO_CHAT, sender: nil)
            } else {
                SVProgressHUD.dismiss()
                debugPrint(error as Any)
            }
        }
    }
    
    //MARK:- Custom Functions


}
