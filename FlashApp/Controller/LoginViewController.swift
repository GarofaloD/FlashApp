//
//  LoginViewController.swift
//  FlashApp
//
//  Created by Daniel Garofalo on 1/4/19.
//  Copyright © 2019 Daniel Garofalo. All rights reserved.
//

import UIKit
import Firebase

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
        
        guard let typedEmail = emailTextField.text else { return }
        guard let typedPassword = passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: typedEmail, password: typedPassword) { (result, error) in
            
            if error == nil {
                print("Login successful")
                self.performSegue(withIdentifier: GO_TO_CHAT, sender: nil)
            } else {
                debugPrint(error as Any)
            }
            
            
            
        }
    }
    
    //MARK:- Custom Functions


}
