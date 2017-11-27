//
//  Utils.swift
//  Admon
//
//  Created by Crealibre on 11/25/17.
//  Copyright © 2017 Vicente Cantu Garcia. All rights reserved.
//

import Foundation
import UIKit

class Utils{
    
    static func onAddPhoto(controller: UIViewController) {
        let picker = UIImagePickerController()
        picker.delegate = controller as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        let optionMenu = UIAlertController(title: nil, message: "Agregar imagen", preferredStyle: .actionSheet)
        let gallery = UIAlertAction(title: "Galeria", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            picker.allowsEditing = false
            picker.sourceType = .photoLibrary
            picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            controller.present(picker, animated: true, completion: nil)
        })
        let camera = UIAlertAction(title: "Camara", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.cameraCaptureMode = .photo
            picker.modalPresentationStyle = .fullScreen
            controller.present(picker,animated: true,completion: nil)
        })
        
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        optionMenu.addAction(gallery)
        optionMenu.addAction(camera)
        optionMenu.addAction(cancel)
        
        controller.present(optionMenu, animated: true, completion: nil)
    }
}
