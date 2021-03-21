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
    
    var dataSource: UICollectionViewDiffableDataSource<Section<AnyHashable, [AnyHashable]>, AnyHashable>?

    override func viewDidLoad() {
        super.viewDidLoad()

        banksViewModel = BanksViewModel(viewDelegate: self, coordinator: coordinator!)

        // Setup CollectionView
        self.configure()
        view = collectionView

        // Fetch Data
        self.fetchData()
    }
}


extension BanksViewController:BanksViewModelViewDelegate {
    func didUpdate() {
        fetchData()
    }
}

extension BanksViewController:UICollectionViewDelegate {
    func configure() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)

        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = AppSettings.AppColor

        collectionView.showsVerticalScrollIndicator = false
        collectionView.collectionViewLayout = configureLayout()
        collectionView.delegate = self

        collectionView.register(BankCell.self, forCellWithReuseIdentifier: BankCell.identifier)
        
        collectionView.register(HeaderView.nibName,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: HeaderView.reuseIdentifier)
        configureDataSource()
        configureSupplementaryView()
    }

    func configureLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in

            let sectionType = self.dataSource?.snapshot().sectionIdentifiers[sectionIndex].headerItem

            if sectionType is BankSection {
                return self.configureBankCellSectionLayout()
            }

            return nil
        }

        return layout
    }
    
    
    func configureBankCellSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(90))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(96))

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item])
       
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10)

        let sectionLayout = NSCollectionLayoutSection(group: group)
        sectionLayout.orthogonalScrollingBehavior = .none

        let headerSupplementary = getHeaderSupplementary()

        sectionLayout.boundarySupplementaryItems = [headerSupplementary]
        
        return sectionLayout
    }
    
    func getHeaderSupplementary() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .estimated(58))
        let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .topLeading)
        headerSupplementary.pinToVisibleBounds = true
        return headerSupplementary
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section<AnyHashable, [AnyHashable]>, AnyHashable>(collectionView:
        collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            if let bank = item as? Bank {
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: BankCell.identifier,
                    for: indexPath) as? BankCell else { return UICollectionViewCell() }
                cell.configure(with: bank)
                return cell
            }

            return nil
        }
    }
    
    func configureSupplementaryView() {
        dataSource?.supplementaryViewProvider = { (collectionView: UICollectionView,
            kind: String,
            indexPath: IndexPath) -> UICollectionReusableView? in

            switch kind {
            case UICollectionView.elementKindSectionHeader:
                guard let headerView = collectionView.dequeueReusableSupplementaryView(
                                                    ofKind: UICollectionView.elementKindSectionHeader,
                                       withReuseIdentifier: HeaderView.reuseIdentifier,
                    for: indexPath) as? HeaderView else { return UICollectionReusableView() }
                headerView.configureHeader(sectionType: (self.dataSource?.snapshot().sectionIdentifiers[indexPath.section].headerItem)!)
                return headerView
            default:
                return nil
            }
        }
    }
    
    //MARK: - Fetch Data
    
    func fetchData() {
        var sections: [Section<AnyHashable, [AnyHashable]>] = []
        
        // use local from other way
        let currentLocation = UserDefaults.standard.string(forKey: "bank.app.current.location") ?? "FR"
        guard let banks = self.banksViewModel.banks else {
            return
        }
        
        // for each countries we have banks.
        for bank in banks {
            var groupCountryBanks = [Bank]()

            if bank.country_code!.uppercased() == currentLocation.uppercased() {
                groupCountryBanks = getBanks(bank: bank.parent_banks!)
                sections.insert(Section(headerItem: BankSection(banks: groupCountryBanks, countryCode: bank.country_code!),
                                                    sectionItems: groupCountryBanks), at: 0)
            } else {
                groupCountryBanks = getBanks(bank: bank.parent_banks!)
                sections.append(Section(headerItem: BankSection(banks: groupCountryBanks, countryCode: bank.country_code!),
                                            sectionItems: groupCountryBanks))
            }
        }
        add(items: sections)
    }
    
    func getBanks(bank:[BankGlobalGroup]) -> [Bank] {
        var banks = [Bank]()
        // for each banks we have sub banks.
        for currentParentBank in bank {
                let currentName = currentParentBank.name
                let currentLogo = currentParentBank.logo_url
                for currentBank in currentParentBank.banks! {
                    banks.append(Bank(id: currentBank.id,
                                      name: currentName,
                                      logo_url: currentBank.logo_url ?? currentLogo,
                                      subName: (currentBank.name ?? currentName)!))
                }
            }
        return banks
    }
    
    
    func add(items: [Section<AnyHashable, [AnyHashable]>]) {
        let payloadDatasource = DataSource(sections: items)

        var snapshot = NSDiffableDataSourceSnapshot<Section<AnyHashable, [AnyHashable]>, AnyHashable>()
        payloadDatasource.sections.forEach {
            snapshot.appendSections([$0])
            snapshot.appendItems($0.sectionItems)
        }
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    
    //MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = dataSource?.snapshot().sectionIdentifiers[indexPath.section].sectionItems[indexPath.row] as? BankGlobalGroup {
            print(item.name ?? "no title")
        }
    }
}
