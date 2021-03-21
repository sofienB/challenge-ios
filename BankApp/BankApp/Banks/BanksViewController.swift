//
//  ViewController.swift
//  BankApp
//
//  Created by sofien Benharchache on 20/03/2021.
//

import UIKit

class BanksViewController: UIViewController {
    weak var coordinator: MainCoordinator?

    var collectionView: UICollectionView!
    var banksViewModel: BanksViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpView()
        banksViewModel = BanksViewModel(viewDelegate: self, coordinator: coordinator!)
    }

    private func setUpView() {
        self.view.backgroundColor = .yellow
    }
}


extension BanksViewController:BanksViewModelViewDelegate {
//    func didUpdate() {
//
//    }
}
