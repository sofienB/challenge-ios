//
//  SectionModels.swift
//  BankApp
//
//  Created by sofien Benharchache on 21/03/2021.
//

import Foundation

struct Section<T: Hashable, U: Hashable>: Hashable {
    let headerItem: T
    let sectionItems: U
}

struct DataSource<T: Hashable> {
    let sections: [T]
}
