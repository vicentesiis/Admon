//
//  LoginViewController.swift
//  Admon
//
//  Created by Vicente Cantu Garcia on 11/11/17.
//  Copyright © 2017 Vicente Cantu Garcia. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func buttonEnterPressed(_ sender: Any) {
        if validateValues(userName: userName.text!, password: password.text!){
            let userData = fetchRequest(entity: "User") as! [User]
            var userName : [String] = []
            var password : [String] = []
            for user in userData{
                userName.append(user.userName!)
                password.append(user.password!)
            }
            if userName.contains(self.userName.text!){
                let index = userName.index(of: self.userName.text!)
                if password[index!] == self.password.text!{
                    UserDefaults.standard.set(true, forKey: "user")
                    UserDefaults.standard.set(userName[index!], forKey: "userLoggedIn")
                    self.performSegue(withIdentifier: "segueEnter", sender: userName[index!])
                }else{
                    alert(title: "Error!", message: "El usuario o la contraseña son incorrectos")
                }
            }else{
                alert(title: "Error!", message: "El usuario o la contraseña son incorrectos")
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
