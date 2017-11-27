//
//  ProductsTableViewController.swift
//  Admon
//
//  Created by Vicente Cantu Garcia on 13/11/17.
//  Copyright © 2017 Vicente Cantu Garcia. All rights reserved.
//

import UIKit

class ProductsTableViewController: UITableViewController {

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
        performSegue(withIdentifier: "segueAddProduct", sender: ((lists[indexPath.section].products)?.allObjects as! [Product])[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let product = (lists[indexPath.section].products)?.allObjects
            if removeRequest(entity: "Product", format: "name == %@", predicate: (product as! [Product])[indexPath.row].name!){
                alert(title: "Bien!", message: "El usuario ha sido eliminado correctamente")
                self.tableView.reloadData()
            }else{
                alert(title: "Error!", message: "Ha ocurrido un problema")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let PVC = segue.destination as! AddProductView
        PVC.product = sender as? Product
    }
    
    @IBAction func buttonCreateListPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Crear Lista", message: "Ingrese el nombre de la lista", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Nombre"
        }
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alerts) in
            let textField = (alert.textFields![0] as UITextField).text!
            if textField != ""{
                let fetch = self.fetchRequest(entity: "List") as! [List]
                for list in fetch{
                    if list.name! == textField {
                        self.perform(#selector(self.messageErrorTextField), with: nil, afterDelay: 0.2)
                        return
                    }
                }
                let list = List(context: self.managedContext)
                list.name = textField
                do{
                    try self.managedContext.save()
                    self.lists.append(list)
                    self.tableView.reloadData()
                }catch (let error){
                    print(error.localizedDescription)
                }
            }else{
                self.perform(#selector(self.messageError), with: nil, afterDelay: 0.2)
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func messageError(){
        alert(title: "Error!", message: "Favor de llenar el campo de nombre")
    }
    
    @objc func messageErrorTextField(){
        alert(title: "Error!", message: "La lista ya esta agregada")
    }
    
    @IBAction func unWindToTableViewProductsCreate(segue: UIStoryboardSegue){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func buttonAddProductPressed(_ sender: Any) {
        if (fetchRequest(entity: "List") as! [List]).isEmpty{
            alert(title: "Error!", message: "Agregue una lista primero")
        }else{
            performSegue(withIdentifier: "segueAddProduct", sender: nil)
        }
    }
    
}
