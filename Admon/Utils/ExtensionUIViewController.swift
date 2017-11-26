//
//  ExtensionUIViewController.swift
//  Admon
//
//  Created by Vicente Cantu Garcia on 14/11/17.
//  Copyright © 2017 Vicente Cantu Garcia. All rights reserved.
//

import Foundation
import UIKit
import CoreData.NSFetchRequest

extension UIViewController{
    
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func alert(title: String, message: String, segue: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
            self.performSegue(withIdentifier: segue, sender: Any?.self)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func validateValues(name: String, lastName: String, userName: String, password: String) -> Bool {
        if name == "" || lastName == "" || userName == "" || password == ""{
            alert(title: "Error!", message: "Todos los campos son requerridos")
            return false
        }
        return true
    }
    
    func validateValues(userName: String, password: String) -> Bool {
        if userName == "" || password == ""{
            alert(title: "Error!", message: "Todos los campos son requerridos")
            return false
        }
        return true
    }
    var managedContext: NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    func fetchRequest(entity: String) -> [Any] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        do{
            let data = try managedContext.fetch(fetchRequest)
            return data
        }catch (let error){
            print(error.localizedDescription)
            return []
        }
    }
    
    func predicateRequest(entity: String, format: String ,predicate: String) -> [Any]{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.predicate = NSPredicate(format: format, predicate)
        do {
            let data = try managedContext.fetch(fetchRequest)
            return data
        } catch (let error) {
            print(error.localizedDescription)
            return []
        }
    }
    
    func removeRequest(entity: String, format: String, predicate: String) -> Bool{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.predicate = NSPredicate(format: format, predicate)
        if let object = try? managedContext.fetch(fetchRequest){
            for data in object{
                managedContext.delete(data as! NSManagedObject)
            }
            do{
                try managedContext.save()
                return true
            }catch (let error){
                print(error.localizedDescription)
                return false
            }
        }
        return false
    }
    // delete objects
//    let fetchRequests = NSFetchRequest<NSManagedObject>(entityName: "Product")
//    do {
//    let arrayManagedObjects = try managedContext.fetch(fetchRequests)
//    for dict in arrayManagedObjects{
//    managedContext.delete(dict)
//    }
//    } catch (let error) {
//    print(error.localizedDescription)
//    }
}
