//
//  Utils.swift
//  UpaxPrueba
//
//  Created by Jair Moreno Gaspar on 3/7/19.
//  Copyright © 2019 Jair Moreno Gaspar. All rights reserved.
//

import Foundation
import SystemConfiguration
import MapKit
import LocalAuthentication

let locationManager: CLLocationManager! = {
    let manager = CLLocationManager()
    manager.desiredAccuracy = kCLLocationAccuracyBest
    //manager.delegate = self
    manager.requestAlwaysAuthorization()
    return manager
}()

func obtener_ubicacion()->CLLocation{
    locationManager.requestAlwaysAuthorization()
    locationManager.startUpdatingLocation()
    
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    
    if let _ = locationManager.location {
        
        return locationManager.location!
        
    }
    else{
        
        print("no tenemos location")
        
        let aux_location = CLLocation(latitude: 0, longitude: 0)
        
        return aux_location
        
    }
    
}

func revisarPermisosLocalizacion() -> Bool {
    if CLLocationManager.locationServicesEnabled() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined, .restricted, .denied:
            return false
        case .authorizedAlways, .authorizedWhenInUse:
            return true
        }
    } else {
        return false
    }
    
}

extension String {
    var isFloat: Bool {
        return Float(self) != nil
    }
}
