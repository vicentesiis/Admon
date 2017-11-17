//
//  ViewController.swift
//  Admon
//
//  Created by Vicente Cantu Garcia on 10/11/17.
//  Copyright © 2017 Vicente Cantu Garcia. All rights reserved.
//

import UIKit
import TextFieldEffects

class InitialViewController: UIViewController {
    
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

    // MARK: - IBActions

    @IBAction func buttonRegisterPressed(_ sender: Any) {
        if validateValues(name: name.text!, lastName: lastName.text!, userName: userName.text!, password: password.text!){
            UserDefaults.standard.setPersistentDomain(["name" : name.text!, "lastName" : lastName.text!, "userName" : userName.text!, "password" : password.text!], forName: "administratorData")
            performSegue(withIdentifier: "segueNavegation", sender: Any?.self)
            UserDefaults.standard.set(true, forKey: "admin")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

