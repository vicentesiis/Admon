//
//  RegisterViewController.swift
//  Admon
//
//  Created by Vicente Cantu Garcia on 11/11/17.
//  Copyright © 2017 Vicente Cantu Garcia. All rights reserved.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func buttonRegisterPressed(_ sender: Any) {
        if validateValues(name: name.text!, lastName: lastName.text!, userName: userName.text!, password: password.text!){
            let fetch = fetchRequest(entity: "User") as! [User]
            for user in fetch{
                if user.userName!.contains(userName.text!){
                    alert(title: "Error!", message: "\(userName.text!) ya esta registrado")
                    return
                }
            }
            let user = User(context: managedContext)
            user.name = name.text!
            user.lastName = lastName.text!
            user.userName = userName.text!
            user.password = password.text!
            do{
                try managedContext.save()
                self.navigationController?.popViewController(animated: true)
            }catch (let error){
                print(error.localizedDescription)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
