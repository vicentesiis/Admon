//
//  PrincipalViewController.swift
//  Admon
//
//  Created by Vicente Cantu Garcia on 11/11/17.
//  Copyright © 2017 Vicente Cantu Garcia. All rights reserved.
//

import UIKit

class PrincipalViewController: UIViewController {

    @IBOutlet weak var labelUsers: UILabel!
    @IBOutlet weak var labelClosure: UILabel!
    @IBOutlet weak var viewAdministrator: UIView!
    let button = UIButton(frame: CGRect(x: 35, y: 127, width: 250, height: 50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let users = fetchRequest(entity: "User")
        labelUsers.text! = "Usuarios: \(users.count)"
        self.title = "Usuario: \(UserDefaults.standard.string(forKey: "userLoggedIn")!)"
        hideObjects(UserDefaults.standard.bool(forKey: "adminLoggedOut"))
        button.backgroundColor = .gray
        button.setTitle("Entrar como administrador", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(button)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        hideObjects(UserDefaults.standard.bool(forKey: "adminLoggedOut"))
        self.title = "Usuario: \(UserDefaults.standard.string(forKey: "userLoggedIn")!)"
        let users = fetchRequest(entity: "User")
        labelUsers.text! = "Usuarios: \(users.count)"
    }
    
    @objc func buttonAction(sender: UIButton!){
        let admin = UserDefaults.standard.persistentDomain(forName: "administratorData")
        let alert = UIAlertController(title: "Administrador", message: "Para acceder a esta funcionalidad necesita la contraseña de el administrador: \(admin!["userName"] ?? "No hay")", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Contraseña"
        }
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alerts) in
            let password = admin!["password"] as? String
            let textField = (alert.textFields![0] as UITextField).text!
            if password!.contains(textField){
                self.hideObjects(false)
                UserDefaults.standard.set(false, forKey: "adminLoggedOut")
            }else{
                self.perform(#selector(self.messageError), with: nil, afterDelay: 0.2)
            }
        }))
        present(alert, animated: true, completion: nil)
    }
    
    @objc func messageError(){
        alert(title: "Error!", message: "Contraseña incorrecta")
    }
    
    func hideObjects(_ bool: Bool) {
        if bool{
            viewAdministrator.isHidden = true
            button.isHidden = false
        }else{
            button.isHidden = true
            viewAdministrator.isHidden = false
        }
    }
}
