//
//  ChatViewController.swift
//  FlashApp
//
//  Created by Daniel Garofalo on 1/4/19.
//  Copyright © 2019 Daniel Garofalo. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {


    //MARK:- Outlets
    @IBOutlet weak var heightConstraint : NSLayoutConstraint!
    @IBOutlet weak var messageTableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    
    //MARK:- Load up functions
    override func viewDidLoad() {
        super.viewDidLoad()

        //TableView delegates
        messageTableView.delegate = self
        messageTableView.dataSource = self
        
        //Text field delegate
        messageTextField.delegate = self
        
        //XIB registration, with registration of the cell and creation of the UNib file
        messageTableView.register(UINib(nibName: "CustomMessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        
        //Call the resizing of the cell
        configureTableView()
        
        //Tap gesture to hide the keyboard. This one needs to be registered manually
        hidingKeyboard()

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
    
    
    @IBAction func sendMessagesWhenPressed(_ sender: UIButton) {
        
        messageTextField.endEditing(true)
        messageTextField.isEnabled = false
        sendButton.isEnabled = false
        
        let messagesDB = Database.database().reference().child("Messages")
        let messageDictionary = ["Sender" : Auth.auth().currentUser?.email, "MessageBody": messageTextField.text!]
        
        //Creates a random key for the message and saves the message dictionary on the message DB
        messagesDB.childByAutoId().setValue(messageDictionary) {
            (error, reference) in
            
            if error == nil {
                print("Message saved successfully!")
                self.messageTextField.isEnabled = true
                self.sendButton.isEnabled = true
                self.messageTextField.text = ""
                
            } else {
                print(error as Any)
            }
        }
        
        
    }
    
    
    //MARK:- TableView Functions
    //Number of Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    //Content of Rows
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell //the one created with the XIB file
        let messageArray = ["First Message", "Secohhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhnd Message", "Third Message"]
        cell.messageBody.text = messageArray[indexPath.row] //senderUsername is a property from the custom cell
        return cell
    }
    
    //Adapt height of the cell
    func configureTableView() {
        messageTableView.rowHeight = UITableView.automaticDimension
        messageTableView.estimatedRowHeight = 500
    }

    
    
    //MARK:- Custom Functions / Keyboard animation
    //Shows up the keyboard (configuration)
    func textFieldDidBeginEditing(_ textField: UITextField) {

        UIView.animate(withDuration: 0.15) {
            self.heightConstraint.constant = 362 //Current measure was adjusted to fix iphone X
            self.view.layoutIfNeeded()
        }
    }
    
    //Hides the keyboard (configuration)
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.15) {
            self.heightConstraint.constant = 50 //Current measure was adjusted to fix iphone X
            self.view.layoutIfNeeded()
        }
    }
    
    //Manual function to hide the keyboard
    func hidingKeyboard(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        messageTableView.addGestureRecognizer(tapGesture)
    }
    
    //Subfunction that calls the functionality to hide the keyboard
    @objc func tableViewTapped(){
        messageTextField.endEditing(true)
    }
    
    
}
