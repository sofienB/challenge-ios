//
//  Bank.swift
//  BankApp
//
//  Created by sofien Benharchache on 21/03/2021.
//

import Foundation

/* Codable Bank to Save into CoreData */
struct Bank : Codable {
    var id: Int?          /* Bank identifier */
    var name: String?     /* Local bank name  */
    var logo_url: String? /* Logo bank url */
}
