//
//  DetailBankCoordinator.swift
//  BankApp
//
//  Created by sofien Benharchache on 20/03/2021.
//

import UIKit

class DetailBankCoordinator: Coordinator {
    weak var parentCoordinator:MainCoordinator?
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let detailBanckVC = DetailBankViewController()
        detailBanckVC.coordinator = self
        navigationController.pushViewController(detailBanckVC, animated: true)
    }
}
