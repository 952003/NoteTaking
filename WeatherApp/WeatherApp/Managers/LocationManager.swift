//
//  LocationManager.swift
//  WeatherApp
//
//  Created by 5. 3 on 13/08/2024.
//

import Foundation
import Combine
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    private var locationManager: CLLocationManager
    @Published var location: CLLocationCoordinate2D?
    
    override init() {
        self.locationManager = CLLocationManager()
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate = locations.last?.coordinate else {return}
        self.location = coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error location: \(error.localizedDescription)")
    }
}
