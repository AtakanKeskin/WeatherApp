//
//  LocationManager.swift
//  WeatherApp
//
//  Created by macbook on 5.12.2021.
//

import CoreLocation
import UIKit

final class LocationManager : NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationManager()
    
    let manager = CLLocationManager()
    
    var completion : ((CLLocation,String) -> Void)?
    
    public func getUserLocation(completion : @escaping ((CLLocation,String) -> Void)){
        self.completion = completion
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        manager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location, preferredLocale: .current) { [self] placemarks, error in
            guard let place = placemarks?.first, error == nil else{
                print("place Not Found")
                return
            }
            if let locality = place.locality{
                completion?(location,locality)
            }
        }
        manager.stopUpdatingLocation()
    }
    
    
}





