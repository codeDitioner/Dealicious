//
//  NewDealViewController.swift
//  Dealicious
//
//  Created by Mina Sedhom on 10/10/22.
//  Copyright © 2022 Mina Sedhom. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class NewDealViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var storeField: UITextField!
    @IBOutlet weak var productField: UITextField!
    @IBOutlet weak var brandField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var dealendsField: UITextField!
    @IBOutlet weak var dealPriceField: UITextField!
    @IBOutlet weak var normalPriceField: UITextField!
    
    @IBAction func onSubmit(_ sender: Any) {
        
        let deal = PFObject(className: "Deals")
        
        deal["author"] = PFUser.current()!
        deal["store"] = storeField.text
        deal["product"] = productField.text
        deal["brand"] = brandField.text
        deal["description"] = descriptionField.text
        deal["dealEnds"] = dealendsField.text
        deal["dealPrice"] = dealPriceField.text
        deal["normalPrice"] = normalPriceField.text
        
        let imageData = imageView.image!.pngData()
        let file = PFFileObject(name: "image.png", data: imageData!)
        
        deal["image"] = file
        
        deal.saveInBackground{ (success, error) in
            if success{
                self.dismiss(animated: true, completion: nil)
                print("saved!")
            } else {
                print("error!")
            }
        }
        
    }
    
    
    
    @IBAction func onCameraButton(_ sender: Any) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .photoLibrary
        } else {
            picker.sourceType = .photoLibrary
        }
        present(picker, animated: true, completion: nil)
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af.imageAspectScaled(toFill: size)
        
        imageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onPostButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
