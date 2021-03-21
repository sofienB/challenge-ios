//
//  BankGlobalGroup.swift
//  BankApp
//
//  Created by sofien Benharchache on 21/03/2021.
//

import Foundation

/* Codable BankGlobalGroup to Save into CoreData */
struct BankGlobalGroup : Codable {
    var name: String?       /* Bank name */
    var logo_url: String?   /* Logo bank url */
    var banks: [Bank]?      /* Local banks */
}
