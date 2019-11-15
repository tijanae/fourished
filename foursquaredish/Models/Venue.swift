//
//  Venue.swift
//  foursquaredish
//
//  Created by Tia Lendor on 11/12/19.
//  Copyright © 2019 Tia Lendor. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

struct VenueResult: Codable {
    let response: ResponseWrapper
    
    static func getVenues(from jsonData: Data) throws -> [Venue]? {
        let response = try JSONDecoder().decode(VenueResult.self, from: jsonData)
        
        return response.response.venues
    }
    
}

struct ResponseWrapper: Codable {
    let venues: [Venue]
}

struct Venue: Codable {
    let name: String
    let location: LocationWrapper
    
}



class LocationWrapper: NSObject, MKAnnotation, Codable {
    
    let lat: Double
    let lng: Double
    
    @objc var coordinate: CLLocationCoordinate2D {
        let latitude = lat
        let longitude = lng
        
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var hasValidCoordinates: Bool {
        return coordinate.latitude != 0 && coordinate.longitude != 0
        
    }

}


