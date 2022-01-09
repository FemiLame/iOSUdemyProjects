//
//  ViewController.swift
//  WhatFlower
//
//  Created by Alex Osipova on 07.01.2022.
//

import UIKit
import CoreML
import Vision
import Alamofire
import SwiftyJSON
import SDWebImage

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            guard let ciImage = CIImage(image: pickedImage) else {
                fatalError("Could not convert UIImage into UIImage")
            }
            detectFlower(flowerImage: ciImage)
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func detectFlower(flowerImage: CIImage) {
        guard let model = try? VNCoreMLModel(for: FlowerClassifier().model) else {
                  fatalError("Could not load ML model")
        }
        
        let request = VNCoreMLRequest(model: model) { request, error in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Unexpected result type from VNCoreMLRequest")
            }
            
            let topResult = results.first
            if let flowerName = topResult?.identifier {
                DispatchQueue.main.async {
                    self.navigationItem.title = flowerName.capitalized
                }
                self.requestWikiInfo(flowerName: flowerName)
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: flowerImage)
        
        do {
            try handler.perform([request])
        }
        catch {
            print(error)
        }
    }
    
    func requestWikiInfo(flowerName: String) {
        let parameters : [String:String] = [
          "format" : "json",
          "action" : "query",
          "prop" : "extracts|pageimages",
          "exintro" : "",
          "explaintext" : "",
          "titles" : flowerName,
          "indexpageids" : "",
          "redirects" : "1",
          "pithumbsize" : "400"
          ]
        
        AF.request("https://en.wikipedia.org/w/api.php", method: .get, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                if let pageID = json["query"]["pageids"][0].string {
                    let flowerDescription = json["query"]["pages"][pageID]["extract"].stringValue
                    DispatchQueue.main.async {
                        self.descriptionLabel.text = flowerDescription
                    }
                    let flowerImageURL =  URL(string: json["query"]["pages"][pageID]["thumbnail"]["source"].stringValue)
                    DispatchQueue.main.async {
                        self.imageView.sd_setImage(with: flowerImageURL)
                    }
                }
            case let .failure(error):
                print(error)
            }
        }
    }

    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true, completion: nil)
    }
}

