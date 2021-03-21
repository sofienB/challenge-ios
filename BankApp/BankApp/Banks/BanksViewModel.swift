//
//  BanksViewModel.swift
//  BankApp
//
//  Created by sofien Benharchache on 21/03/2021.
//

import UIKit

@objc
protocol BanksViewModelViewDelegate: class {
    @objc optional func didUpdate()
}

class BanksViewModel {
    private var networkManager: NetworkManager!

    weak var viewDelegate: BanksViewModelViewDelegate?
    weak var coordinator: MainCoordinator?

    var banks: [CountryBank]?
    
    init(viewDelegate: BanksViewModelViewDelegate, coordinator:MainCoordinator) {
        self.viewDelegate = viewDelegate
        self.coordinator = coordinator
        
        self.networkManager = NetworkManager()
        self.fetchBanks()
    }

    func fetchBanks() {
        // Fetch from CoreData else from Networking
        networkManager.fetchBanks() { banks, error in
            if error != NetworkResponse.success {
                print(error.debugDescription)
            } else {
                self.banks = banks
                // Save into CoreData
            }
        }
    
    }
}

