//
//  ParkingController.swift
//  RoadPal
//
//  Created by Michael Wong on 2/4/19.
//  Copyright © 2019 MWstudio. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ParkingController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // after the view is load, check the location service
        checkLocationServices()
    }
    
    func checkLocationServices(){
        // if location service is enabled
        if CLLocationManager.locationServicesEnabled(){
            // set up location manager
            setupLocationManager()
            // and check location authorization
            checkLocationAuthorization()
        }else{
            // show an alert to ask user to turn on location service
        }
    }
    
    func setupLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationAuthorization(){
        switch CLLocationManager.authorizationStatus() {
        
        case .authorizedWhenInUse: // if have this permission, map display user's current location
            mapView.showsUserLocation = true
            break
        case .denied: // if permission is denied, tell them how to do setting
            break
        case .notDetermined: // if permission is not determined, ask for 'authorizedWhenInUse' permission
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            break
        case .authorizedAlways: // do not do anything
            break
        }
    }
    
    func centerViewOnUserLocation(){
        // if the location of locationManager is not null, create a region object
        if let location = locationManager.location?.coordinate{
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: 10000, longitudinalMeters: 10000)
            mapView.setRegion(region, animated: true)
        }
    }
    
}

extension ParkingController: CLLocationManagerDelegate{
    
    
    func locationManager( manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        
    }
    
    /**
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        <#code#>
    }
 */
}
