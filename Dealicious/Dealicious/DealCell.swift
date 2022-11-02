//
//  DealCell.swift
//  Dealicious
//
//  Created by Mina Sedhom on 10/10/22.
//  Copyright © 2022 Mina Sedhom. All rights reserved.
//

import UIKit

class DealCell: UITableViewCell {

    @IBOutlet weak var userNameLabel: UILabel!
        //displays the name of the store and maybe address? maybe a new label for address
    @IBOutlet weak var userImage: UIImageView!
        //shows a logo of the store so its easy to recognize
    @IBOutlet weak var dealPriceLabel: UILabel!
        //shows price of label
    @IBOutlet weak var dealTitleLabel: UILabel!
        //show the title of the deal
    @IBOutlet weak var dealImageView: UIImageView!
        //shows the user generated image of the store
    @IBOutlet weak var dealExpirationLabel: UILabel!
        //shows the expiration date of deal
    @IBOutlet weak var storeLocationLabel: UILabel!
        //shows which store the deal can be found

    
    ///
    //    @IBOutlet weak var numLikesLabel: UILabel!
    //        //displays number of likes
    //    @IBOutlet weak var numDislikesLabel: UILabel!
    //        //displays number of dislikes
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    @IBAction func onThumbsUpAction(_ sender: Any) {
//    }
//    @IBAction func onThumbsDownAction(_ sender: Any) {
//    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
