//
//  EditProfileViewController.swift
//  Dealicious
//
//  Created by Kevin Nguyen on 10/31/22.
//  Copyright © 2022 Mina Sedhom. All rights reserved.
//
 
import UIKit
import Parse
import AlamofireImage
 
class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var aboutmeTextField: UITextField!
    @IBOutlet weak var testLabel: UILabel!
    
    @IBAction func onSubmit(_ sender: Any) {
        
        let userProfile = PFUser.current()!
        userProfile["aboutMe"] = aboutmeTextField.text
        let imageData = imageView.image!.pngData()
        let file = PFFileObject(name: "image.png", data: imageData!)
        userProfile["image"] = file
          
        userProfile.saveInBackground { (success, error) in
              if success {
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
              picker.sourceType = .camera
          } else {
              picker.sourceType = .photoLibrary
          }
          
          present(picker, animated: true, completion: nil)
      }
      func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
          let image = info[.editedImage] as! UIImage
          let size = CGSize(width: 300, height: 300)
          let scaledImage = image.af.imageScaled(to: size)
          
          imageView.image = scaledImage
          
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
