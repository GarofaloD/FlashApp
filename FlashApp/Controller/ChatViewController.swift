//
//  ChatViewController.swift
//  FlashApp
//
//  Created by Daniel Garofalo on 1/4/19.
//  Copyright © 2019 Daniel Garofalo. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    

    //MARK:- Outlets
    
    @IBOutlet weak var messageTableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    
    
    //MARK:- Properties
    
    //MARK:- Load up functions
    override func viewDidLoad() {
        super.viewDidLoad()

        //TableView delegates
        messageTableView.delegate = self
        messageTableView.dataSource = self
        
        //XIB registration, with registration of the cell and creation of the UNib file
        messageTableView.register(UINib(nibName: "CustomMessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        
        //Call the resizing of the cell
        configureTableView()
        
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

    
    
}
