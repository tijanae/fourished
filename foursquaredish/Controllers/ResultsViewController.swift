//
//  ResultsViewController.swift
//  foursquaredish
//
//  Created by Tia Lendor on 11/15/19.
//  Copyright © 2019 Tia Lendor. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
   
    
    var venueResults: [Venue]!
    
    
    lazy var venueResultList: UITableView = {
        let resultList = UITableView()
        resultList.register(ResultsTVC.self, forCellReuseIdentifier: "resultsCell")
        return resultList
    }()
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDelegates()
        addSubViews()
        contraints()

        // Do any additional setup after loading the view.
    }
    
    private func setUpDelegates() {
        
    }
    
    private func addSubViews(){
        view.addSubview(venueResultList)
    }
    
    private func contraints() {
        
    }
    
    private func venueResultListConstraint(){
        venueResultList.translatesAutoresizingMaskIntoConstraints = false
        [venueResultList.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
         venueResultList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
         venueResultList.leadingAnchor.constraint(equalTo: view.leadingAnchor),
         venueResultList.trailingAnchor.constraint(equalTo: view.trailingAnchor)].forEach{$0.isActive = true}
    }
    
    

}

extension ResultsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        venueResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let venue = venueResults[indexPath.row]
        guard let resultsCell =  tableView.dequeueReusableCell(withIdentifier: "results", for: indexPath) as? ResultsTVC
        else {return UITableViewCell()}
        resultsCell.searchedName.text = venue.name
        return resultsCell
    }
    
    
}
