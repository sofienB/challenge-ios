//
//  Coordinator.swift
//  BankApp
//
//  Created by sofien Benharchache on 20/03/2021.
//

import UIKit

protocol Coordinator:AnyObject {
    var childCoordinators: [Coordinator] {get set}
    var navigationController: UINavigationController {get set}
    
    func start()
}
