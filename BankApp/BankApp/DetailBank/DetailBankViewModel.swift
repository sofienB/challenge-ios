//
//  DetailBankViewModel.swift
//  BankApp
//
//  Created by sofien Benharchache on 21/03/2021.
//

import Foundation

@objc
protocol DetailBankViewModelViewDelegate: class {
    @objc optional func didUpdate()
}

class DetailBankViewModel {
    private var networkManager: NetworkManager!

    weak var viewDelegate: DetailBankViewModelViewDelegate?
    weak var coordinator: DetailBankCoordinator?

    var bank: Bank?
    
    init(forId id:Int, viewDelegate: DetailBankViewModelViewDelegate, coordinator:DetailBankCoordinator) {
        self.viewDelegate = viewDelegate
        self.coordinator = coordinator
        
        self.networkManager = NetworkManager()
        self.fetchBank(id)
    }

    func fetchBank(_ id:Int) {
        // Here fetch for single bank
        // Get specific information about a Bank
    }
}

