//
//  LocationHelper.swift
//  Stormy
//
//  Created by Mohamed Moukhtar on 5/12/16.
//  Copyright © 2016 Mohamed Moukhtar. All rights reserved.
//

import Foundation
import CoreLocation

protocol position {
    var coordinates: (latitude: Double, longitude: Double)? { get }
}

enum Status {
    case Error
    case Succeed
    case UnableToFindLocation
}

enum AuthorizationType {
    case Always
    case WhenInUse
}

class Location: position  {
    
    var coordinates: (latitude: Double, longitude: Double)?
    var country: String?
    var locality: String?
    var subLocality: String?
    var postalCode: String?
    var administrativeArea: String?
    var subAdministrativeArea: String?
    
    enum AddressField {
        case country
        case locality
        case subLocality
        case administrativeArea
        case subAdministrativeArea
        case postalCode
    }
    
    init (latitude: Double, longitude: Double) {
        self.coordinates = (latitude,longitude)
    }
    
    func getGeoLocationFromCoordinates(location: CLLocation, addressFileds: [AddressField], completion: (address: String, error: NSError?) -> Void) {
        CLGeocoder().reverseGeocodeLocation(location) {
            (clPlaceMarks: [CLPlacemark]?, error: NSError?) in
            
            if let placeMarks = clPlaceMarks {
                completion(address: self.constructAddress(placeMarks[0], addressFileds: addressFileds), error: error)
            } else {
                completion(address: "", error: error)
            }
        }
    }
    
    func constructAddress(placeMark: CLPlacemark, addressFileds: [AddressField]) -> String {
        for addressFiled in addressFileds {
            switch addressFiled {
            case .country: country = placeMark.country
            case .locality: locality = placeMark.locality
            case .subLocality: subLocality = placeMark.subLocality
            case .administrativeArea: administrativeArea = placeMark.administrativeArea
            case .subAdministrativeArea: subAdministrativeArea = placeMark.subAdministrativeArea
            case .postalCode: postalCode = placeMark.postalCode
            }
        }
        var address: String = ""
        if subAdministrativeArea != nil {
            address = address + "\(subAdministrativeArea!), "
        }
        if administrativeArea != nil {
            address = address + "\(administrativeArea!) "
        }
        if postalCode != nil {
            address = address + "- \(postalCode!)\n"
        } else {
            if address != "" {
                address = address + "\n"
            }
        }
        if subLocality != nil {
            address = address + "\(subLocality!), "
        }
        if locality != nil {
            address = address + "\(locality!)\n"
        }
        if country != nil {
            address = address + "\(country!)"
        }
        return address
    }
}















