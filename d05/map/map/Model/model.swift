//
//  model.swift
//  map
//
//  Created by Sydney COHEN on 6/4/18.
//  Copyright © 2018 Sydney COHEN. All rights reserved.
//

import Foundation
import MapKit

class Pin: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let coordinate: CLLocationCoordinate2D
    let location: CLLocation
    let color: UIColor
    
    init(title: String, locationName: String, coordinate: CLLocationCoordinate2D, location: CLLocation, color: UIColor) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        self.location = location
        self.color = color
        
        super.init()
    }

    var subtitle: String? {
        return locationName
    }
}

var addresses : [Pin] = [
    Pin(title: "Ecole 42", locationName: "96 Boulevard Beissiéres, 75017, Paris",
        coordinate: CLLocationCoordinate2D(latitude: 48.8965523, longitude: 2.3162668),
        location: CLLocation(latitude: 48.8965523, longitude: 2.3162668),
        color: UIColor.green),
    Pin(title: "Home", locationName: "59 rue des archives, 75003, Paris",
        coordinate: CLLocationCoordinate2D(latitude: 48.8619522, longitude: 2.3565365),
        location: CLLocation(latitude: 48.8619522, longitude: 2.3565365),
        color: UIColor.blue),
    Pin(title: "Annecy", locationName: "6 rue notre dame, 74000 , Annecy, France",
        coordinate: CLLocationCoordinate2D(latitude: 45.9003476, longitude: 6.1233938),
        location: CLLocation(latitude: 45.9003476, longitude: 6.1233938),
        color: UIColor.lightGray),
    Pin(title: "Val d'isére", locationName: "Val d'isére",
        coordinate: CLLocationCoordinate2D(latitude: 45.4233929, longitude: 6.9445622),
        location: CLLocation(latitude: 45.4233929, longitude: 6.9445622),
        color: UIColor.yellow),
    Pin(title: "Apple", locationName: "Sacramento",
        coordinate: CLLocationCoordinate2D(latitude: 37.33182, longitude: -122.0333687),
        location: CLLocation(latitude: 37.33182, longitude: -122.0333687),
        color: UIColor.brown),
    Pin(title: "Himalaya", locationName: "Montagne de l'Himalaya",
        coordinate: CLLocationCoordinate2D(latitude: 30.0762021, longitude: 76.5791213),
        location: CLLocation(latitude: 30.0762021, longitude: 76.5791213),
        color: UIColor.red),
    Pin(title: "Machu Picchu", locationName: "Ruines du Machu Picchu",
        coordinate: CLLocationCoordinate2D(latitude: -13.163136, longitude: -72.5471569),
        location: CLLocation(latitude: -13.163136, longitude: -72.5471569),
        color: UIColor.red),
]
