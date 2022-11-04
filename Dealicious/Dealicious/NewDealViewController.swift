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
import CoreLocation

import SkyFloatingLabelTextField

class NewDealViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        return manager
    }()
    
    
    let datePicker = UIDatePicker()
    
    @IBOutlet weak var dealImageView3: UIImageView!
    @IBOutlet weak var dealImageView2: UIImageView!
    @IBOutlet weak var dealImageView: UIImageView!
    @IBOutlet weak var storeField: SkyFloatingLabelTextField!
    @IBOutlet weak var productField: SkyFloatingLabelTextField!
    @IBOutlet weak var brandField: UITextField!
    @IBOutlet weak var descriptionField: SkyFloatingLabelTextField!
    @IBOutlet weak var dealendsField: UITextField!
    @IBOutlet weak var dealPriceField: UITextField!
    @IBOutlet weak var normalPriceField: UITextField!
    
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    var images:[UIImageView] = []
    
    @IBAction func onSubmit(_ sender: Any) {
        
        if (validateForms()) {
            
            let deal = PFObject(className: "Deals")
            
            deal["author"] = PFUser.current()!
            deal["store"] = storeField.text
            deal["product"] = productField.text
            deal["brand"] = brandField.text
            deal["description"] = descriptionField.text
            deal["dealEnds"] = dealendsField.text
            deal["dealPrice"] = dealPriceField.text
            deal["normalPrice"] = normalPriceField.text
            
            let imageData = dealImageView.image!.pngData()
            let file = PFFileObject(name: "image.png", data: imageData!)
            deal["image"] = file
            
            let imageData2 = dealImageView2.image!.pngData()
            let file2 = PFFileObject(name: "image.png", data: imageData2!)
            deal["image2"] = file2

            let imageData3 = dealImageView3.image!.pngData()
            let file3 = PFFileObject(name: "image.png", data: imageData3!)
            deal["image3"] = file3
            
            //Pushing location to DB
            if let location = locationManager.location {
                let latitude = location.coordinate.latitude
                let longitude = location.coordinate.longitude
                // Handle location update
                print("Lng: \(longitude) & Lat: \(latitude)")
                deal["longitude"] = longitude
                deal["latitude"] = latitude
            }
            
            deal.saveInBackground{ (success, error) in
                if success{
                    self.dismiss(animated: true, completion: nil)
                    print("saved!")
                } else {
                    print("error!")
                }
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
        for im in images {
            if im.image?.pngData() == UIImage(named:"image_placeholder")?.pngData() {
                im.image = scaledImage
                break
            }
        }
        //imageView.image = scaledImage
       
        dismiss(animated: true, completion: nil)
    }
    
    
    func validateForms () -> Bool {
        var valid = true
        
        if descriptionField.text!.isEmpty {
            descriptionField.errorMessage = "Required Field"
            valid = false
        } else {
            descriptionField.errorMessage = ""
            valid = true
        }
        
        if storeField.text!.isEmpty {
            storeField.errorMessage = "Required Field"
            valid = false

        } else {
            storeField.errorMessage = ""
            valid = true
        }
        
        if productField.text!.isEmpty {
            productField.errorMessage = "Required Field"
            valid = false
        } else {
            productField.errorMessage = ""
            valid = true
        }
        return valid
    }
    
    @IBAction func onResetButton(_ sender: Any) {
        descriptionField.text = ""
        storeField.text = ""
        productField.text = ""
        brandField.text = ""
        dealendsField.text = ""
        dealPriceField.text = ""
        normalPriceField.text = ""
        images.forEach { (im) in
            im.image = UIImage(named:"image_placeholder")
        }
    }
    
    @IBAction func addImageButton(_ sender: Any) {
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
    
    
    @IBAction func onCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        
        submitButton.layer.cornerRadius = 5
        addButton.layer.cornerRadius = 5
        
        dealImageView.layer.cornerRadius = 10
        dealImageView2.layer.cornerRadius = 10
        dealImageView3.layer.cornerRadius = 10
        images.append(dealImageView)
        images.append(dealImageView2)
        images.append(dealImageView3)

        createDatePicker()
        
        dealPriceField.delegate = self
        normalPriceField.delegate = self
        
        // Request a user’s location once
        // Do any additional setup after loading the view.
        
    }
    
    func createToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonPressed))
        toolbar.setItems([doneButton], animated: true)
        
        return toolbar
    }
    
    func createDatePicker() {
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        dealendsField.inputView = datePicker
        dealendsField.inputAccessoryView = createToolbar()
    }
    
    @objc func doneButtonPressed () {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        self.dealendsField.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    // handling currency input fields
    var amt: Int = 0
    var amt2: Int = 0
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField === self.dealPriceField {
            if let digit = Int(string){
                amt = amt*10 + digit
                dealPriceField.text = updateAmount()
            }
            if string == "" {
                amt = amt/10
                dealPriceField.text = amt == 0 ? "" : updateAmount()
            }
        }
        if textField === self.normalPriceField {
            if let digit = Int(string){
                amt2 = amt2*10 + digit
                normalPriceField.text = updateAmount2()
            }
            if string == "" {
                amt2 = amt2/10
                normalPriceField.text = amt2 == 0 ? "" : updateAmount2()
            }
        }
        return false
    }
    
    // for dealPriceField
    func updateAmount() -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.currency
        let amount = Double(amt/100) + Double(amt%100)/100
        return formatter.string(from: NSNumber(value: amount))
    }
    // for normalPriceField
    func updateAmount2() -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.currency
        let amount = Double(amt2/100) + Double(amt2%100)/100
        return formatter.string(from: NSNumber(value: amount))
    }

    
}


//Handling location
extension NewDealViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            // Handle location update
            print("\(latitude) & \(longitude)")
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus
    ) {
        // Get the current location permissions
        let status = CLLocationManager.authorizationStatus()
        
        // Handle each case of location permissions
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
            print("status granted")
        case .denied:
            print("status denied")
        case .notDetermined:
            print("status not yet determined")
        case .restricted:
            print("status restricted")
        }
    }
    
}
