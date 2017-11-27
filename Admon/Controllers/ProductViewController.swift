//
//  ProductViewController.swift
//  Admon
//
//  Created by Vicente Cantu Garcia on 13/11/17.
//  Copyright © 2017 Vicente Cantu Garcia. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {

    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var nameProduct: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var priceProduct: UILabel!
    @IBOutlet weak var quantityProduct: UILabel!
    @IBOutlet weak var quantityStepper: UIStepper!
    @IBOutlet weak var quantityText: UILabel!
    
    var product : Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quantityStepper.wraps = true
        quantityStepper.autorepeat = true
        quantityStepper.maximumValue = Double(product!.quantity)
        if let data = product?.image{
            if let image = UIImage(data: data as Data){
                self.imageProduct.image = image
            }
        }
        self.nameProduct.text = product?.name
        self.quantityProduct.text = "Cantidad: \(String(describing: product!.quantity))"
        self.priceProduct.text = "$\(String(describing: product!.price))"
        self.totalPrice.text = "Cantidad total..."
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sell(_ sender: Any) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func stepperPressed(_ sender: Any) {
        quantityText.text = String(Int(quantityText.text!)! + 1)
        self.totalPrice.text = "Cantidad total: $\(String(product!.price * Double(quantityText.text!)!))"
    }
}
