//
//  DealDetailsViewController.swift
//  Dealicious
//
//  Created by Abby Clarke on 10/24/22.
//  Copyright © 2022 Mina Sedhom. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class DealDetailsViewController: UIViewController {
    
    var deal: PFObject!


    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var dealImage: UIImageView!
    @IBOutlet weak var storeLocationLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dealDescriptionLabel: UILabel!
    @IBOutlet weak var normalPriceLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
 //for the image
        let ImageFile = deal["image"] as! PFFileObject
        let urlString = ImageFile.url!
        let url = URL(string: urlString)!

        if (dealImage != nil){
            dealImage.af.setImage(withURL: url)
        }
        
        let user = deal["author"] as! PFUser
        
//        // get the date to show
//        let dateFormatterGet = DateFormatter()
//        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
//
//        let dateFormatterPrint = DateFormatter()
//        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
//
//        let date: NSDate? = dateFormatterGet.date(from: deal["createdAt"] as! String) as NSDate?
//        print(dateFormatterPrint.string(from: date! as Date))
        
        // Update all labels
        priceLabel.text =  deal["dealPrice"] as? String
        brandLabel.text =  deal["brand"] as? String
        productLabel.text  =  deal["product"] as? String
        usernameLabel.text  =  user.username
        storeLocationLabel.text  =  deal["store"] as? String
        dealDescriptionLabel.text =  deal["description"] as? String
        normalPriceLabel.text = deal["normalPrice"] as? String
//        dealPostedLabel.text = dateFormatterPrint.string(from: date! as Date)
        
        
        
        
        //Some UI Stuff
        
        priceLabel.layer.cornerRadius = priceLabel.frame.width/2
        priceLabel.layer.masksToBounds = true
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
