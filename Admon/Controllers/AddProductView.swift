//
//  AddProductView.swift
//  Admon
//
//  Created by Vicente Cantu Garcia on 13/11/17.
//  Copyright © 2017 Vicente Cantu Garcia. All rights reserved.
//

import UIKit
import MobileCoreServices
import CoreData

class AddProductView: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource{

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var quantity: UITextField!
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var listPicker: UIPickerView!
    @IBOutlet weak var buttonList: UIButton!
    @IBOutlet weak var list: UILabel!
    @IBOutlet weak var viewInformation: UIView!

    var picker = [List]()

    override func viewDidLoad() {
        super.viewDidLoad()
        listPicker.delegate = self
        listPicker.isHidden = true
        picker = self.fetchRequest(entity: "List") as! [List]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    @IBAction func addList(_ sender: Any) {
        self.view.endEditing(true)
        viewInformation.isHidden = true
        listPicker.isHidden = false
    }
    
    @IBAction func addProduct(_ sender: Any) {
        let price = self.price.text
        let quantity = self.quantity.text
        let name = self.name.text
        if price!.isEmpty || quantity!.isEmpty || name!.isEmpty || list.text! == "Pulsa \"Agregar lista\""{
            alert(title: "Error!", message: "Los campos nombre, precio, cantidad y lista son necesarios")
        }else{
            if Int(price!)! < 1 || Int(quantity!)! < 1{
                alert(title: "Error!", message: "La cantidad y el precio deben ser mayores a 0")
            }else{
                for product in fetchRequest(entity: "Product") as! [Product]{
                    if product.name == name! {
                        alert(title: "Error!", message: "El producto \(name!) ya existe")
                        return
                    }
                }
                let list = List(context: managedContext)
                for data in predicateRequest(entity: "List", format: "name == %@", predicate: self.list.text!) as! [List]{
                    list.name = data.name
                }
                let product = Product(context: managedContext)
                product.name = name!
                product.price = Double(price!)!
                product.quantity = Int32(quantity!)!
                product.list = list
                if let image = imageProduct.image{
                    if let dataImage = UIImageJPEGRepresentation(image, 1){
                        product.image = dataImage as NSData?
                    }
                }
                do{
                    try managedContext.save()
                    alert(title: "Bien!", message: "Se ha guardado correctamente el producto", segue: "unWindToTableViewProductsCreate")
                }catch (let error){
                    print(error.localizedDescription)
                }
            }
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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return picker[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return picker.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        list.text = picker[row].name!
        viewInformation.isHidden = false
        listPicker.isHidden = true
    }
}
