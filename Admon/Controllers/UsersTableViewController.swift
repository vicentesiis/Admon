//
//  UsersTableViewController.swift
//  Admon
//
//  Created by Vicente Cantu Garcia on 13/11/17.
//  Copyright © 2017 Vicente Cantu Garcia. All rights reserved.
//

import UIKit

class UsersTableViewController: UITableViewController {

    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.users = self.fetchRequest(entity: "User") as! [User]
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func unWindToTableViewUserCreate(segue: UIStoryboardSegue){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func unWindToTableViewUserUpdate(segue: UIStoryboardSegue){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].userName!
        cell.detailTextLabel?.text = "\(users[indexPath.row].name!) \(users[indexPath.row].lastName!)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segueUser", sender: users[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        for i in 0..<users.count{
            if users[i].userName == UserDefaults.standard.string(forKey: "userLoggedIn")!{
                if indexPath.row == i{
                    return false
                }
            }
        }
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            if removeRequest(entity: "User", format: "userName == %@", predicate: users[indexPath.row].userName!){
                alert(title: "Bien!", message: "El usuario ha sido eliminado correctamente")
                users.remove(at: indexPath.row)
                self.tableView.reloadData()
            }else{
                alert(title: "Error!", message: "Ha ocurrido un problema")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let userVC = segue.destination as! NewUserViewController
        userVC.user = sender as? User
    }
}
