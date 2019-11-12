//
//  SearchTabViewController.swift
//  foursquaredish
//
//  Created by Tia Lendor on 11/5/19.
//  Copyright © 2019 Tia Lendor. All rights reserved.
//

import UIKit
import MapKit

class SearchTabViewController: UIViewController {

    lazy var mapView: MKMapView = {
       let map = MKMapView()
        return map
    }()
    
    lazy var venueSearch: UISearchBar = {
        let venue = UISearchBar()
        return venue
    }()
    
    lazy var locationSearch: UISearchBar = {
       let location = UISearchBar()
        return location
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setUpDelegates()
        addSubViews()
        contraints()
        // Do any additional setup after loading the view.
    }
    
    private func setUpDelegates(){
        mapView.delegate = self
        venueSearch.delegate = self
        locationSearch.delegate = self
    }
    
    private func addSubViews() {
        view.addSubview(venueSearch)
        view.addSubview(locationSearch)
        view.addSubview(mapView)
    
    }
    
    private func contraints() {
        venueSearchConstraint()
        locationViewConstraint()
        mapViewConstraint()
    }
    
    
    private func venueSearchConstraint(){
        venueSearch.translatesAutoresizingMaskIntoConstraints = false
        [venueSearch.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
         venueSearch.leadingAnchor.constraint(equalTo: view.leadingAnchor),
         venueSearch.trailingAnchor.constraint(equalTo: view.trailingAnchor),
         venueSearch.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 110)].forEach{$0.isActive = true}
        
       
    }
    
    private func locationViewConstraint(){
        locationSearch.translatesAutoresizingMaskIntoConstraints = false
        [locationSearch.topAnchor.constraint(equalTo: venueSearch.bottomAnchor),
         locationSearch.leadingAnchor.constraint(equalTo: view.leadingAnchor),
         locationSearch.trailingAnchor.constraint(equalTo: view.trailingAnchor),
         locationSearch.bottomAnchor.constraint(equalTo: venueSearch.bottomAnchor, constant: 80)].forEach{$0.isActive = true}
        /*
         mapView.translatesAutoresizingMaskIntoConstraints = false
                [mapView.topAnchor.constraint(equalTo: view.topAnchor),
                 mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                 mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                 mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)].forEach{$0.isActive = true}
         */
    }
    
    
    private func mapViewConstraint() {
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        [mapView.topAnchor.constraint(equalTo: locationSearch.bottomAnchor),
         mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
         mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
         mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)].forEach{$0.isActive = true}
    }
    

 

}

extension SearchTabViewController: MKMapViewDelegate {}


extension SearchTabViewController: UISearchBarDelegate {
    
//   func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        searchString = searchText
//    }
//
//    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
//        locationEntry.showsCancelButton = true
//        return true
//    }
//
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        locationEntry.showsCancelButton = false
//        locationEntry.resignFirstResponder()
//    }
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//         //create activity indicator
//        let activityIndicator = UIActivityIndicatorView()
//        activityIndicator.center = self.view.center
//        activityIndicator.startAnimating()
//        self.view.addSubview(activityIndicator)
//
//        searchBar.resignFirstResponder()
//
//        //search request
//        let searchRequest = MKLocalSearch.Request()
//        searchRequest.naturalLanguageQuery = searchBar.text
//        let activeSearch = MKLocalSearch(request: searchRequest)
//        activeSearch.start { (response, error) in
//            activityIndicator.stopAnimating()
//
//            if response == nil {
//                print(error)
//            } else {
//                //remove annotations
//                let annotations = self.mapView.annotations
//                self.mapView.removeAnnotations(annotations)
//
//                //get data
//                let latitud = response?.boundingRegion.center.latitude
//                let longitud = response?.boundingRegion.center.longitude
//
//                let newAnnotation = MKPointAnnotation()
//                newAnnotation.title = searchBar.text
//                newAnnotation.coordinate = CLLocationCoordinate2D(latitude: latitud!, longitude: longitud!)
//                self.mapView.addAnnotation(newAnnotation)
//
//                //to zoom in the annotation
//                let coordinateRegion = MKCoordinateRegion.init(center: newAnnotation.coordinate, latitudinalMeters: self.searchRadius * 2.0, longitudinalMeters: self.searchRadius * 2.0)
//                self.mapView.setRegion(coordinateRegion, animated: true)
//            }
//        }
//
//    }
}
