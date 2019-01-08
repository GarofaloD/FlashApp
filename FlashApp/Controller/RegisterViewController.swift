//
//  RegisterViewController.swift
//  FlashApp
//
//  Created by Daniel Garofalo on 1/4/19.
//  Copyright © 2019 Daniel Garofalo. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    
    
    //MARK:- Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    

    
    //MARK:- Properties
    
    
    //MARK:- Load up Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    //MARK:- Buttons
    @IBAction func registerUserWhenPressed(_ sender: UIButton) {
        
        guard let typedEmail = emailTextField.text else {return}
        guard let typedPassword = passwordTextField.text else {return}
        
        
        //Authentication with Firebase
        //On the complation block, we want to get back the user authentication info and the error code, hence the markup
        Auth.auth().createUser(withEmail: typedEmail, password: typedPassword) { (user, error) in
            
            if error == nil {
                print("Registration Successful!")
                self.performSegue(withIdentifier: GO_TO_CHAT, sender: nil)
            } else {
                print(error as Any)
            }
            
            
        }
        
        
    }
    
    
    //MARK:- Custom Functions
    
    
    

}
