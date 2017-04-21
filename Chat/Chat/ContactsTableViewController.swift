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

class ContactsTableViewController: UITableViewController {
    
    var firebaseReference: FIRDatabaseReference!
    var firebaseHandle: FIRDatabaseHandle?
    var firebaseDataSnapshot: [FIRDataSnapshot] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogout(_ sender: UIButton) {
        
        didTapLogoutButton()
    }
//
//    
//    deinit {
//        if let referenceHandle = firebaseHandle {
//            self.firebaseReference.child("messages").removeObserver(withHandle: referenceHandle)
//        }
//    }
//    
//    
//    func configureFirebaseDatabase(tableView: UITableView) -> Int {
//        
//        firebaseHandle = self.firebaseReference.child("messages").observe(.childAdded, with: { [weak self] (snapshot) -> Void in
//            guard let strongSelf = self else { return }
//            
//            strongSelf.firebaseDataSnapshot.append(snapshot)
//            strongSelf.tableView.insertRows(at: [IndexPath(row: strongSelf.firebaseDataSnapshot.count - 1, section: 0)], with: .automatic)
//        })
//        
//        return firebaseDataSnapshot.count
//        
//    }
//    
//
//    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return configureFirebaseDatabase(tableView: tableView)
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        
//        return 0
//    }
//
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        
//        let messageDataSnapshot = firebaseDataSnapshot[indexPath.row]
//        
//        guard let messageData = messageDataSnapshot.value as? [String:String] else { return cell }
//       
//
//        
//
//        return cell
//    }
    

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
