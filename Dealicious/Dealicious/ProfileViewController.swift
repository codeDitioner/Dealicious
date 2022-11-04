//
//  ProfileViewController.swift
//  Dealicious
//
//  Created by Kevin Nguyen on 10/31/22.
//  Copyright © 2022 Mina Sedhom. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class ProfileViewController: UIViewController {
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var userDescription: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        if let description = PFUser.current()!["aboutMe"] as? String {
            userDescription.text = description
        }
        if let imageFile = PFUser.current()!["image"] as? PFFileObject {
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            profileImage.af.setImage(withURL: url)
        }
        if let username = PFUser.current()!["username"] as? String {
            userLabel.text = username
        }
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
