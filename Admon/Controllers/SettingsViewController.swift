//
//  SettingsViewController.swift
//  Admon
//
//  Created by Vicente Cantu Garcia on 13/11/17.
//  Copyright © 2017 Vicente Cantu Garcia. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonLogoutUserPressed(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "user")
        UserDefaults.standard.set(true, forKey: "adminLoggedOut")
    }
    
    @IBAction func buttonLogoutAdministratorPressed(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "adminLoggedOut")
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func buttonStartPresentationPressed(_ sender: Any) {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        alert(title: "Eliminación completada", message: "Favor de reiniciar la aplicación")
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
