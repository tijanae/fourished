//
//  VenueAPIHelper.swift
//  foursquaredish
//
//  Created by Tia Lendor on 11/12/19.
//  Copyright © 2019 Tia Lendor. All rights reserved.
//

import Foundation

class VenueAPIHelper {

    private init() {}

    static let shared = VenueAPIHelper()

    func getVenues(venue: String?, lat: Double, long: Double, completionHandler: @escaping (Result<[Venue], AppError>) -> () ) {

        var searchWord = ""
        if let venueSearch = venue {
            searchWord = venueSearch.replacingOccurrences(of: " ", with: "-")
        }
        var urlStr: URL {
            guard let url = URL(string: "https://api.foursquare.com/v2/venues/search?ll=\(lat),\(long)&client_id=\(Secrets.clientID)&client_secret=\(Secrets.clientSecret)&v=20191104&query=\(searchWord)&limit=3")
                else {fatalError("Error Invaild URL")}
            return url
        }


        NetworkHelper.manager.performDataTask(withUrl: urlStr, andMethod: .get) { (result) in

            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
                return
            case .success(let data):
                do {
                    let venue = try VenueResult.getVenues(from: data)
                    guard let venueUnwrapped = venue else {
                        completionHandler(.failure(.invalidJSONResponse)); return
                    }
                    completionHandler(.success(venueUnwrapped))                } catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        }
    }
}
