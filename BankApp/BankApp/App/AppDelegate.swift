//
//  AppDelegate.swift
//  BankApp
//
//  Created by sofien Benharchache on 20/03/2021.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var coordinator: MainCoordinator?
    var window: UIWindow?

    lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        return locationManager
    }()
    
    private func requestAuthorization() {
        if #available(iOS 11.0, *) {
            locationManager.requestAlwaysAuthorization()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let navigationController = UINavigationController()
        navigationController.navigationBar.barTintColor = AppSettings.AppColor
        UINavigationBar.appearance().titleTextAttributes =
            [NSAttributedString.Key.font: AppSettings.NavigationFont!,
             NSAttributedString.Key.foregroundColor : AppSettings.HeaderTextColor]
        
        coordinator = MainCoordinator(navigationController: navigationController)
        coordinator?.start()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        // Request Autorization for Location
        requestAuthorization()
        
        // Fetch Current Location
        BALocation().setupLocation()

        return true
    }
}

