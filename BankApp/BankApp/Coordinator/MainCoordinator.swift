//
//  MainCoordinator.swift
//  BankApp
//
//  Created by sofien Benharchache on 20/03/2021.
//

import UIKit

class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
        let bankVC = BanksViewController()
        bankVC.coordinator = self
        bankVC.title = "Banks"
        navigationController.pushViewController(bankVC, animated: true)
    }
    
    func showBank() {
        let detailBankVC = DetailBankCoordinator(navigationController: navigationController)
        detailBankVC.parentCoordinator = self
        childCoordinators.append(detailBankVC)
        detailBankVC.start()
    }
    
    func childDidFinish(_ child:Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== child }
    }
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        if let detailBankViewController = fromViewController as? DetailBankViewController {
            childDidFinish(detailBankViewController.coordinator!)
        }
    }
}
