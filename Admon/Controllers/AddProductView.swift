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
    @IBOutlet weak var buttonUpdateOrAdd: UIButton!
    @IBOutlet weak var buttonAddImage: UIButton!
    
    var product : Product?
    var picker = [List]()

    override func viewDidLoad() {
        super.viewDidLoad()
        if let product = self.product{
            self.name.text = product.name
            self.price.text = "\(product.price)"
            self.quantity.text = "\(product.quantity)"
            if let data = product.image{
                if let image = UIImage(data: data as Data){
                    self.imageProduct.image = image
                    self.buttonAddImage.setTitle("Cambiar Imagen", for: .normal)
                }
            }
            self.list.text = product.list?.name
            self.buttonList.setTitle("Cambiar lista", for: .normal)
            self.buttonUpdateOrAdd.setTitle("Actualizar", for: .normal)
            self.title = "Modificar producto"
        }
        listPicker.delegate = self
        listPicker.isHidden = true
        picker = self.fetchRequest(entity: "List") as! [List]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addImage(_ sender: Any) {
        Utils.onAddPhoto(controller: self)
    }
    
    @IBAction func addList(_ sender: Any) {
        self.view.endEditing(true)
        viewInformation.isHidden = true
        listPicker.isHidden = false
    }
    
    @IBAction func addProduct(_ sender: Any) {
        let price : Double? = Double(self.price.text!)
        let quantity : Int? = Int(self.quantity.text!)
        let name = self.name.text
        if let product = self.product{
            if (price == nil) || (quantity == nil) || name!.isEmpty || list.text! == "Pulsa \"Agregar lista\""{
                alert(title: "Error!", message: "Los campos nombre, precio, cantidad y lista son necesarios")
            }else{
                if price! < 1 || quantity! < 1{
                    alert(title: "Error!", message: "La cantidad y el precio deben ser mayores a 0")
                }else{
                    if self.product?.name != name{
                        for product in fetchRequest(entity: "Product") as! [Product]{
                            if product.name == name! {
                                alert(title: "Error!", message: "El producto \(name!) ya existe")
                                return
                            }
                        }
                    }
                    product.name = name!
                    product.price = Double(price!)
                    product.quantity = Int32(quantity!)
                    product.list = (predicateRequest(entity: "List", format: "name == %@", predicate: self.list.text!) as! [List])[0]
                    if let image = imageProduct.image{
                        if let dataImage = UIImageJPEGRepresentation(image, 1){
                            product.image = dataImage as NSData?
                        }
                    }
                    do{
                        try managedContext.save()
                        alert(title: "Bien!", message: "Se ha guardado correctamente el producto", segue: "unWindToTableViewProductsCreate")
                        print(fetchRequest(entity: "Product"))
                    }catch (let error){
                        print(error.localizedDescription)
                    }
                }
            }
        }else{
            if (price == nil) || (quantity == nil) || name!.isEmpty || list.text! == "Pulsa \"Agregar lista\""{
                alert(title: "Error!", message: "Los campos nombre, precio, cantidad y lista son necesarios")
            }else{
                if price! < 1 || quantity! < 1{
                    alert(title: "Error!", message: "La cantidad y el precio deben ser mayores a 0")
                }else{
                    for product in fetchRequest(entity: "Product") as! [Product]{
                        if product.name == name! {
                            alert(title: "Error!", message: "El producto \(name!) ya existe")
                            return
                        }
                    }
                    let product = Product(context: managedContext)
                    product.name = name!
                    product.price = Double(price!)
                    product.quantity = Int32(quantity!)
                    product.list = (predicateRequest(entity: "List", format: "name == %@", predicate: self.list.text!) as! [List])[0]
                    if let image = imageProduct.image{
                        if let dataImage = UIImageJPEGRepresentation(image, 1){
                            product.image = dataImage as NSData?
                        }
                    }
                    do{
                        try managedContext.save()
                        alert(title: "Bien!", message: "Se ha guardado correctamente el producto", segue: "unWindToTableViewProductsCreate")
                        print(fetchRequest(entity: "Product"))
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageProduct.image = chosenImage
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
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
        buttonList.setTitle("Cambiar lista", for: .normal)
    }
}
