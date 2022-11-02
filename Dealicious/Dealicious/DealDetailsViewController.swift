//
//  DealDetailsViewController.swift
//  Dealicious
//
//  Created by Abby Clarke on 10/24/22.
//  Copyright © 2022 Mina Sedhom. All rights reserved.
//

import UIKit
import Parse

class DealDetailsViewController: UIViewController {
    
    var deal: [String:Any]!

    @IBOutlet weak var dealImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(deal)
//        print(deal["price"])

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
