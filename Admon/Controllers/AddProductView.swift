//
//  AddProductView.swift
//  Admon
//
//  Created by Vicente Cantu Garcia on 13/11/17.
//  Copyright © 2017 Vicente Cantu Garcia. All rights reserved.
//

import UIKit
import MobileCoreServices

class AddProductView: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var quantity: UITextField!
    @IBOutlet weak var imageProduct: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addImage(_ sender: Any) {
        if  UIImagePickerController.isSourceTypeAvailable(.camera){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = true
            imagePicker.setEditing(true, animated: true)
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func addProduct(_ sender: Any) {
        if name.text! != "" || price.text! != "" || quantity.text! != ""{
            if Int(price.text!)! != 0{
                
            }else{
                alert(title: "Error!", message: "El precio debe de ser mayores de 0")
            }
            if Int(quantity.text!)! != 0{
                
            }else{
                alert(title: "Error!", message: "La cantidad debe de ser mayores de 0")
            }
        }else{
            alert(title: "Error!", message: "Los campos: nombre, precio y producto son requeridos")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        self.dismiss(animated: true, completion: nil)
        if mediaType == kUTTypeImage as String{
            if let image = info[UIImagePickerControllerEditedImage] as? UIImage{
                self.imageProduct.image = image
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            }
        }
    }
}
