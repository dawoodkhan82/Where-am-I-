//
//  MapView.swift
//  Where am I?
//
//  Created by Dawood Khan on 2/15/16.
//  Copyright © 2016 Dawood Khan. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class MapView: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet var map: MKMapView!
    var manager1:CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager1 = CLLocationManager()
        manager1.delegate = self
        manager1.desiredAccuracy = kCLLocationAccuracyBest
        manager1.requestWhenInUseAuthorization()
        manager1.startUpdatingLocation()
        
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation:CLLocation = locations[0]
        let latitude:CLLocationDegrees = userLocation.coordinate.latitude
        let longitude:CLLocationDegrees = userLocation.coordinate.longitude
        let latDelta:CLLocationDegrees = 0.01
        let lonDelta:CLLocationDegrees = 0.01
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        map.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
         map.addAnnotation(annotation)

        
    }
    
    
}
