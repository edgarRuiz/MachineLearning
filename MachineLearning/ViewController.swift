//
//  ViewController.swift
//  MachineLearning
//
//  Created by Edgar Ruiz on 6/24/18.
//  Copyright © 2018 Edgar Ruiz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var uiImageView: UIImageView!
    var imagePicker = UIImagePickerController();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self;
        imagePicker.sourceType = .photoLibrary;
        imagePicker.allowsEditing = false;
        
    }

    @IBAction func cameraButtonPressed(_ sender: Any) {
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let userPickedImage  = info[UIImagePickerControllerOriginalImage] as? UIImage{
            uiImageView.image = userPickedImage;
        }
        dismiss(animated:true, completion: nil)

    }
    
}

