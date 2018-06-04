//
//  FirstViewController.swift
//  map
//
//  Created by Sydney COHEN on 6/4/18.
//  Copyright © 2018 Sydney COHEN. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    let locationMgr = CLLocationManager()

    
    @IBAction func locate(_ sender: UIButton) {
        print("I'm being pressed")
        let status  = CLLocationManager.authorizationStatus()
        
        if status == .notDetermined {
            locationMgr.requestWhenInUseAuthorization()
            return
        }
        
        if status == .denied || status == .restricted {
            let alert = UIAlertController(title: "Location Services Disabled", message: "Please enable Location Services in Settings", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            
            present(alert, animated: true, completion: nil)
            return
        }
        
        locationMgr.delegate = self
        locationMgr.startUpdatingLocation()
        
        self.centerMapOnLocation(location: locationMgr.location!)
        
    }
    
    @IBAction func segmentedControlAction(_ sender: UISegmentedControl) {
        switch (sender.selectedSegmentIndex) {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        default:
            mapView.mapType = .hybrid
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.showsUserLocation = true;
        let initialLocation = CLLocation(latitude: 48.8965523, longitude: 2.3162668)
        centerMapOnLocation(location: initialLocation)
        
        let pin = Pin(title: "42",
                      locationName: "Ecole 42",
                      coordinate: CLLocationCoordinate2D(latitude: 48.8965523, longitude: 2.3162668))
        mapView.addAnnotation(pin)
    }
    
//    Center map on lauch
    let regionRadius: CLLocationDistance = 500
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation = locations.last!
        print("Current location: \(currentLocation)")
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }

}

extension UIViewController: MKMapViewDelegate {
    // 1
    public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 2
        guard let annotation = annotation as? Pin else { return nil }
        // 3
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        // 4
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            // 5
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
}

