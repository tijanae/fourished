//
//  VenueCell.swift
//  foursquaredish
//
//  Created by Tia Lendor on 11/15/19.
//  Copyright © 2019 Tia Lendor. All rights reserved.
//

import UIKit

class VenueCell: UICollectionViewCell {
    
    lazy var venueImage: UIImageView = {
       let searchedimage = UIImageView()
        searchedimage.image = UIImage(named: "defaultImage")
        return searchedimage
    }()
    
    lazy var venueName: UILabel = {
       let searchedVenue = UILabel()
        searchedVenue.textAlignment = .center
        searchedVenue.font = UIFont.systemFont(ofSize: 12)
        return searchedVenue
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        addConstraints()
        contentView.backgroundColor = .white
    }
    
    private func addViews() {
        contentView.addSubview(venueImage)
        contentView.addSubview(venueName)
    }
    
    private func addConstraints() {
        venueImageConstraint()
        venueNameConstraint()
    }
    
    private func venueImageConstraint() {
        venueImage.translatesAutoresizingMaskIntoConstraints = false
        [venueImage.topAnchor.constraint(equalTo: contentView.topAnchor),
         venueImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)].forEach{$0.isActive = true}
        
    }
    
    private func venueNameConstraint(){
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
