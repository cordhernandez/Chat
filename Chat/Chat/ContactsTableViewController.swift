//
//  ChatMessagesTableViewController.swift
//  Chat
//
//  Created by Cordero Hernandez on 4/20/17.
//  Copyright © 2017 Cordero. All rights reserved.
//

import Firebase
import Foundation
import UIKit

class ContactsTableViewController: UITableViewController, ContactDataDelegate {
    
    private var contacts: [FirebaseContactsModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        FirebaseDatabase.instance.contactDataDelegate = self
        FirebaseDatabase.instance.goLoadContacts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func onLogout(_ sender: UIButton) {
        
        didTapLogoutButton()
    }
    
    func contactDataReceived(contacts: [FirebaseContactsModel]) {
        self.contacts = contacts
        
        //get the name of the current user
        getTheNameOfTheCurrentUser(with: contacts)
        
        tableView.reloadData()
    }
    
    func getTheNameOfTheCurrentUser(with contacts: [FirebaseContactsModel]) {
        
        for contact in contacts {
            
            if contact.id == FirebaseAuthorization.instance.getUserID() {
                FirebaseAuthorization.instance.userName = contact.name
                
            }
            
        }
        
    }
    

    // MARK: Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return contacts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ContactsTableViewCell else {
            
            return UITableViewCell()
        }
        
        let row = indexPath.row
        let contact = contacts[row]
        
        cell.contactIDLabel.text = contact.id
        cell.contactNameLabel.text = contact.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        goToChatViewController()
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: Segues
extension ContactsTableViewController {
    
    func didTapLogoutButton() {
        
        if FirebaseAuthorization.instance.logOutUser() {
            
            dismiss(animated: true, completion: nil)
        }
        else {
            
            createAlertForUser(title: "There is a problem logging you out", message: "Our system is having trouble logging you out, please try again")
        }
        
    }
    
}
