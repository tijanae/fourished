//
//  ResultsTVC.swift
//  foursquaredish
//
//  Created by Tia Lendor on 11/15/19.
//  Copyright © 2019 Tia Lendor. All rights reserved.
//

import UIKit

class ResultsTVC: UITableViewCell {

    lazy var searchedName: UILabel = {
       let searchedVenue = UILabel()
        searchedVenue.textAlignment = .center
        searchedVenue.font = UIFont.systemFont(ofSize: 12)
        return searchedVenue
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
