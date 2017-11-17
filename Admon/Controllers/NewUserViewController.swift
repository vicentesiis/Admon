//
//  NewUserViewController.swift
//  Admon
//
//  Created by Vicente Cantu Garcia on 13/11/17.
//  Copyright © 2017 Vicente Cantu Garcia. All rights reserved.
//

import UIKit

class NewUserViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var buttonRegister: UIButton!
    
    var user : User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = self.user{
            name.text! = user.name!
            lastName.text! = user.lastName!
            userName.text! = user.userName!
            password.text! = user.password!
            buttonRegister.setTitle("Actualizar", for: .normal)
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerOrChange(_ sender: Any) {
        if validateValues(name: name.text!, lastName: lastName.text!, userName: userName.text!, password: password.text!){
            if let user = self.user{
                let lastUserName = user.userName!
                if !(user.userName! == userName.text!){
                    let fetch = fetchRequest(entity: "User") as! [User]
                    for user in fetch{
                        if user.userName! == userName.text!{
                            alert(title: "Error", message: "El nombre de usuario: \(userName.text!) ya existe")
                            return
                        }
                    }
                }
                user.name = name.text!
                user.lastName = lastName.text!
                user.userName = userName.text!
                user.password = password.text!
                do{
                    try managedContext.save()
                    print(UserDefaults.standard.string(forKey: "userLoggedIn")!)
                    if lastUserName == UserDefaults.standard.string(forKey: "userLoggedIn")!{
                        print("Entro")
                        UserDefaults.standard.set(userName.text!, forKey: "userLoggedIn")
                    }
                    alert(title: "Datos Actualizados", message: "Se han actualizado los datos para: \(userName.text!)", segue: "unWindToTableViewUserUpdate")
                }catch (let error){
                    alert(title: "Ocurrio un error", message: "\(error.localizedDescription)")
                }
            }else{
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
                    self.user = user
                    do{
                        try managedContext.save()
                        alert(title: "Datos Actualizados", message: "Se ha creado la cuenta para: \(userName.text!)", segue: "unWindToTableViewUserCreate")
                    }catch (let error){
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unWindToTableViewUserCreate"{
            let userTV = segue.destination as? UsersTableViewController
            userTV?.users.append(user!)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
