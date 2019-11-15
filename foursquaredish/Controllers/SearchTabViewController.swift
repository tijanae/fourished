//
//  SearchTabViewController.swift
//  foursquaredish
//
//  Created by Tia Lendor on 11/5/19.
//  Copyright © 2019 Tia Lendor. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class SearchTabViewController: UIViewController {
    
    private let locationManager = CLLocationManager()
    
    var initialLocation = CLLocation(latitude: 40.752054, longitude: -73.949417)
    
    var searchRadius: Double = 2000
    
    var venues = [Venue]() {
        didSet {
            venues.forEach{(location) in
                let annotation = MKPointAnnotation()
                annotation.title = location.name
                annotation.coordinate = location.location.coordinate
                mapView.addAnnotation(annotation)
                
            }
        }
    }
    
    

    lazy var mapView: MKMapView = {
       let map = MKMapView()
        return map
    }()
    
    lazy var venueSearch: UISearchBar = {
        let venue = UISearchBar()
        venue.placeholder = "Venue"
        return venue
    }()
    
    lazy var locationSearch: UISearchBar = {
       let location = UISearchBar()
        location.placeholder = "Location"
        return location
    }()
    
    lazy var venueCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .lightGray
        cv.register(VenueCell.self, forCellWithReuseIdentifier: "venueCell")
        cv.alpha = 0.0
        
        return cv
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setUpDelegates()
        addSubViews()
        contraints()
        locationAuthorization()
      
        // Do any additional setup after loading the view.
    }
    
    
    private func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate{
            let coordinateRegion = MKCoordinateRegion.init(center: initialLocation.coordinate, latitudinalMeters: searchRadius * 2.0, longitudinalMeters: searchRadius * 2.0)
            mapView.setRegion(coordinateRegion, animated: true)
        }
    }
    
    private func locationAuthorization() {
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            centerViewOnUserLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            mapView.showsUserLocation = true
            mapView.userTrackingMode = .follow
            locationManager.requestLocation()
            locationManager.startUpdatingLocation()
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    private func loadVenueData(venue: String?, lat: Double, long: Double) {
        VenueAPIHelper.shared.getVenues(venue: venue, lat: lat, long: long) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let data):
                self.venues = data
                print(data)
            }
        }
    }
    
    private func loadVenueImageData() {
        
    }
    
    
    
    
    private func setUpDelegates(){
        mapView.delegate = self
        venueSearch.delegate = self
        locationSearch.delegate = self
        locationManager.delegate = self
        
    }
    
    private func addSubViews() {
        view.addSubview(venueSearch)
        view.addSubview(locationSearch)
        view.addSubview(mapView)
        mapView.addSubview(venueCollection)
    
    }
    
    private func contraints() {
        venueSearchConstraint()
        locationViewConstraint()
        mapViewConstraint()
        venueCollectionConstraint()
    }
    
    
    private func venueCollectionConstraint(){
        venueCollection.translatesAutoresizingMaskIntoConstraints = false
        [venueCollection.topAnchor.constraint(equalTo: view.topAnchor, constant: 600),
         venueCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
         venueCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
         venueCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor)].forEach{$0.isActive = true}
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
       
    }
    
    
    private func mapViewConstraint() {
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        [mapView.topAnchor.constraint(equalTo: locationSearch.bottomAnchor),
         mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
         mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
         mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)].forEach{$0.isActive = true}
    }
    

 

}

extension SearchTabViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("New Location: \(locations)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("Authorization status changed to \(status.rawValue)")
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
             centerViewOnUserLocation()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }

}

extension SearchTabViewController: MKMapViewDelegate {

}

extension SearchTabViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        venues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "venueCell", for: indexPath) as? VenueCell else {return UICollectionViewCell()}
        let data = venues[indexPath.row]
        
        /*
         ImageManager.manager.getImage(urlStr: data.book_image) { (result) in
             DispatchQueue.main.async {
                 switch result{
                 case .failure(let error):
                     print(error)
                 case .success(let image):
                     cell.bookImage.image = image
                 }
             }
         }
         cell.bookName.text = data.title
         cell.bookText.text = data.description
         return cell
         */
        
        cell.venueName.text = data.name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        <#code#>
//    }
}



extension SearchTabViewController: UISearchBarDelegate {
    
//   func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        searchString = searchText
//    }
//
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
         //create activity indicator
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.center = self.view.center
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)

        searchBar.resignFirstResponder()

        //search request
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = locationSearch.text
        let activeSearch = MKLocalSearch(request: searchRequest)
        activeSearch.start { (response, error) in
            activityIndicator.stopAnimating()

            if response == nil {
                print(error)
            } else {
                //remove annotations
                let annotations = self.mapView.annotations
                self.mapView.removeAnnotations(annotations)
                self.venueCollection.alpha = 1

                //get data
                
                let latitud = response?.boundingRegion.center.latitude
                let longitud = response?.boundingRegion.center.longitude
                self.loadVenueData(venue: self.venueSearch.text, lat: latitud!, long: longitud!)
//                let newAnnotation = MKPointAnnotation()
//                newAnnotation.title = searchBar.text
//                newAnnotation.coordinate = CLLocationCoordinate2D(latitude: latitud!, longitude: longitud!)
//                self.mapView.addAnnotation(newAnnotation)

                //to zoom in the annotation
//                let coordinateRegion = MKCoordinateRegion.init(center: newAnnotation.coordinate, latitudinalMeters: self.searchRadius * 2.0, longitudinalMeters: self.searchRadius * 2.0)
//                self.mapView.setRegion(coordinateRegion, animated: true)
                
            }
        }

    }
}
