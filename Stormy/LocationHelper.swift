//
//  LocationHelper.swift
//  Stormy
//
//  Created by Mohamed Moukhtar on 5/12/16.
//  Copyright © 2016 Mohamed Moukhtar. All rights reserved.
//

import Foundation


protocol position {
    var coordinates: (latitude: Double, longitude: Double) { get }
}

struct Location: position {
    let coordinates: (latitude: Double, longitude: Double)
    let name: String?
    
    init (latitude: Double, longitude: Double, name: String? = nil) {
        self.coordinates = (latitude,longitude)
        self.name = name
    }
}
