//
//  ChatViewController.swift
//  FlashApp
//
//  Created by Daniel Garofalo on 1/4/19.
//  Copyright © 2019 Daniel Garofalo. All rights reserved.
//

import UIKit
import Firebase
import ChameleonFramework

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    //MARK:- Properties
    var messageArray = [Message]()
    

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

        //retrieving messages from the Firebase DB
        retrieveMessages()
        
    }
    

    //MARK:- Buttons
    //Logout from the app
    @IBAction func logOutWhenPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()   //Function coming from the FireBase api for authentication
            navigationController?.popToRootViewController(animated: true) //Based on the fact that will take us to the initial VC embedded on the NavController
        }
        catch {
            print("Problems signing out")
        }
    }
    
    //Sending messages.
    @IBAction func sendMessagesWhenPressed(_ sender: UIButton) {
        
        //Clearing and disabling buttons and fields
        messageTextField.endEditing(true)
        messageTextField.isEnabled = false
        sendButton.isEnabled = false
        
        //Cration of Messagaes DB on firebase with the mdictionary model for each message assigned to each different user
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
    
    //Retrieve messages from FirebaseDB
    func retrieveMessages() {
        
        messageTableView.separatorStyle = .none
        
        //New GET call to our DB to get the messages and check if there are new thing on a new snapsshot element
        let messageDB = Database.database().reference().child("Messages")
        messageDB.observe(.childAdded) { (snapshot) in
            
            //Format new elements into dictionary elements (with separate entities)
            let snapshotValue = snapshot.value as! Dictionary<String,String>
            let text = snapshotValue["MessageBody"]!
            let sender = snapshotValue["Sender"]!

            //Saving each entity into a new Message object
            let message = Message()
            message.messageBody = text
            message.messageSender = sender
            
            //Saving the new objects into the objects array (declared up top)
            self.messageArray.append(message)
            
            //Reformating the table to get the messages and expand or contract the cells
            self.configureTableView()
            self.messageTableView.reloadData()
            
        }
        
    }
    
    
    
    //MARK:- TableView Functions
    //Number of Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    //Content of Rows
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell //the one created with the XIB file

        //For the cell assigning different elements from the objects in the array
        cell.messageBody.text = messageArray[indexPath.row].messageBody
        cell.senderUserName.text = messageArray[indexPath.row].messageSender
        cell.avatarImageView.image = UIImage(named: "egg")
        
        
        if cell.senderUserName.text == Auth.auth().currentUser?.email {
            cell.avatarImageView.backgroundColor = UIColor.flatMint()
            cell.messageBackground.backgroundColor = UIColor.flatSkyBlue()
        } else {
            cell.avatarImageView.backgroundColor = UIColor.flatWatermelon()
            cell.messageBackground.backgroundColor = UIColor.flatGray()
        }
        
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
