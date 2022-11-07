//
//  DealsViewController.swift
//  Dealicious
//
//  Created by Mina Sedhom on 10/10/22.
//  Copyright © 2022 Mina Sedhom. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage
class DealsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var deals = [PFObject]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: "navigateToNextViewController")
//
//
//        func navigateToNextViewController(){
//            self.performSegue(withIdentifier: "goProfile", sender: self)
//        }

        
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className:"Deals")
        query.includeKey("author")
        query.limit = 15
        query.order(byDescending: "createdAt")
        
        query.findObjectsInBackground{ (deals, error) in
            if deals != nil {
                self.deals = deals!
                self.tableView.reloadData()
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DealCell") as! DealCell
        
        let deal = deals[indexPath.row]
        let user = deal["author"] as! PFUser
        cell.dealTitleLabel.text = deal["product"] as! String
        cell.dealPriceLabel.text = deal["dealPrice"] as! String
        cell.storeLocationLabel.text = deal["store"] as! String
        cell.dealExpirationLabel.text = deal["dealEnds"] as! String
        cell.userNameLabel.text = user.username
        
        
        
        let ImageFile = deal["image"] as! PFFileObject
        let urlString = ImageFile.url!
        let url = URL(string: urlString)!
        
        cell.dealImageView.af.setImage(withURL: url)
        
        
        //some UI Features
        
        //Curve edges of Deal Image
        cell.dealImageView.layer.cornerRadius = 5
        cell.dealImageView.layer.masksToBounds = true
        
        //make user profile a circle
        cell.userImage.layer.cornerRadius = 4
        cell.userImage.layer.masksToBounds = true
        
        
        return cell
    }
    
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //prep for segue to deals detail
        //find the selected deal
//        let cell = sender as! UITableViewCell
//        let indexPath = tableView.indexPath(for: cell)!
//        let deal = deals[indexPath.row]
//
//
//        //pass the selected deal to details view controller
//
//
//        let detailsViewController = segue.destination as! DealDetailsViewController
//        detailsViewController.deal = deal
//        let ImageFile = deal["image"] as! PFFileObject
//        let urlString = ImageFile.url!
//        let url = URL(string: urlString)!
//
//        if (deal["image"] != nil){
//            detailsViewController.dealImage.af.setImage(withURL: url)
//        }
        
        // have to pass these individually as a workaround because I couldn'y figure out how to pass the whole PFObject type
//
//        detailsViewController.price =  deal["dealPrice"] as? String
//        detailsViewController.brand =  deal["brand"] as? String
//        detailsViewController.product =  deal["product"] as? String
//        detailsViewController.username =  user.username
//        detailsViewController.imageDeal =  deal["dealImage"] as? PFFileObject
//        detailsViewController.storeLocation =  deal["store"] as? String
//        detailsViewController.descript =  deal["description"] as? String
//
//
//
//
//
//
//
    }
}
