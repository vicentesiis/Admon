//
//  SellProductsTableView.swift
//  Admon
//
//  Created by Vicente Cantu Garcia on 13/11/17.
//  Copyright © 2017 Vicente Cantu Garcia. All rights reserved.
//

import UIKit

class SellProductsTableView: UITableViewController {
    
    var lists = [List]()
    var products = [Product]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.lists = fetchRequest(entity: "List") as! [List]
        self.products = fetchRequest(entity: "Product") as! [Product]
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
        return lists.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        for i in 0..<lists.count{
            if section == i{
                return lists[i].name
            }
        }
        return ""
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath)
        let products = (lists[indexPath.section].products)?.allObjects as! [Product]
        cell.textLabel?.text = products[indexPath.row].name
        cell.detailTextLabel?.text = "$\(products[indexPath.row].price)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        for i in 0..<lists.count{
            if section == i{
                return predicateRequest(entity: "Product", format: "list.name == %@", predicate: lists[i].name!).count
            }
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segueSell", sender: ((lists[indexPath.section].products)?.allObjects as! [Product])[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let PVC = segue.destination as! ProductViewController
        PVC.product = sender as? Product
    }
}
