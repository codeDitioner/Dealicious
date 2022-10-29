//
//  NewDealViewController.swift
//  Dealicious
//
//  Created by Mina Sedhom on 10/10/22.
//  Copyright © 2022 Mina Sedhom. All rights reserved.
//

import UIKit
<<<<<<< Updated upstream

class NewDealViewController: UIViewController {

=======
import Parse
import AlamofireImage
import CoreLocation

class NewDealViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        return manager
    }()
    
    
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
    
    
>>>>>>> Stashed changes
    @IBAction func onPostButton(_ sender: Any) {
        if let location = locationManager.location {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            // Handle location update
            print("\(latitude) & \(longitude)")
        }
        //dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        
        // Request a user’s location once
        // Do any additional setup after loading the view.
        
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
