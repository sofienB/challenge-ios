//
//  ViewController.swift
//  BankApp
//
//  Created by sofien Benharchache on 20/03/2021.
//

import UIKit

class BanksViewController: UIViewController {
    weak var coordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpView()
    }

    private func setUpView() {
        self.view.backgroundColor = .yellow
    }
}

