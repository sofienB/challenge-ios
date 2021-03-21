//
//  BALocation.swift
//  BankApp
//
//  Created by sofien Benharchache on 21/03/2021.
//

import Foundation
import CoreLocation

struct BALocation {
    func setupLocation() {
        locationFromLocal()
        if CLLocationManager.locationServicesEnabled() {
            let status: CLAuthorizationStatus = CLLocationManager.authorizationStatus()
            if status == CLAuthorizationStatus.notDetermined {
                guard let location = CLLocationManager().location else { return }
                CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
                    if placemarks != nil && !placemarks!.isEmpty {
                        UserDefaults.standard.set(placemarks![0].isoCountryCode, forKey: "bank.app.current.location")
                        UserDefaults.standard.synchronize()
                    }
                })
            }
        }
    }
    
    func locationFromLocal() {
        let currentLocation = String(Locale.preferredLanguages[0].prefix(2))
        UserDefaults.standard.set(currentLocation, forKey: "bank.app.current.location")
        UserDefaults.standard.synchronize()
    }
    
    // Country from .plist file
    static func getCountry(from countryCode: String) -> String? {
        func getPlist(withName name: String) -> [String:String]?
        {
            var config: [String: Any]?
            if let infoPlistPath = Bundle.main.url(forResource: "Countrys", withExtension: "plist") {
                do {
                    let infoPlistData = try Data(contentsOf: infoPlistPath)
                    
                    if let dict = try PropertyListSerialization.propertyList(from: infoPlistData, options: [], format: nil) as? [String: Any] {
                        config = dict
                    }
                } catch {
                    print(error)
                }
            }
            return config as? [String:String]
        }
        let country = getPlist(withName: "Countrys")?.filter({ (key, value) -> Bool in
            key == countryCode
        })

        return country?[countryCode]
    }
}

