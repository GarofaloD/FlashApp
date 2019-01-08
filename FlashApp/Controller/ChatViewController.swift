//
//  ChatViewController.swift
//  FlashApp
//
//  Created by Daniel Garofalo on 1/4/19.
//  Copyright © 2019 Daniel Garofalo. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

    //MARK:- Outlets
    
    //MARK:- Properties
    
    //MARK:- Load up functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    //MARK:- Buttons
    @IBAction func logOutWhenPressed(_ sender: UIBarButtonItem) {
        
        do {
            try Auth.auth().signOut()   //Function coming from the FireBase api
            navigationController?.popToRootViewController(animated: true) //Based on the fact that will take us to the initial VC embedded on the NavController
        }
        catch {
            print("Problems signing out")
        }
        
    }
    
    //MARK:- Custom Functions

}
