//
//  ViewController.swift
//  MachineLearning
//
//  Created by Edgar Ruiz on 6/24/18.
//  Copyright © 2018 Edgar Ruiz. All rights reserved.
//

import UIKit
import CoreML
import Vision

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
            
            guard let ciImage = CIImage(image: userPickedImage) else{
                fatalError("Could not convert UIImage to CIImage")
            }
            detect(ciImage: ciImage);
            print()
        }
        dismiss(animated:true, completion: nil)

    }
    
    func detect(ciImage : CIImage){
        print("here")
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else{
            fatalError("Loading CoreML Model failed")
        }
            let request = VNCoreMLRequest(model: model) { (request, error) in
                guard let results = request.results as? [VNClassificationObservation] else{
                    fatalError("Model failed to process image")
                }
                if let firstItem = results.first{
                    if firstItem.identifier.contains("hot dog"){
                        self.navigationItem.title = "Hot dog indeed!!"
                    }else{
                        self.navigationItem.title = "Not a hot dog!"
                    }
                }
            }
        
        let handler = VNImageRequestHandler(ciImage: ciImage);
        
        do{
            try handler.perform([request]);
        }catch{
            print(error)
        }
    
    }
    
}

