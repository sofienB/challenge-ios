//
//  Bank.swift
//  BankApp
//
//  Created by sofien Benharchache on 21/03/2021.
//

import Foundation
import CoreData

/* Codable BankModel */
struct BankModel : Codable, Hashable {

    var id: Int?            /* Bank identifier */
    var name: String?       /* Local bank name  */
    var subName: String?    /* Logo bank url */
    var logo_url: String?   /* Logo bank url */
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        logo_url = try values.decodeIfPresent(String.self, forKey: .logo_url)
        subName = try values.decodeIfPresent(String.self, forKey: .subName)
    }
    
    init(id:Int?, name:String?, logo_url:String?, subName:String) {
        self.id = id
        self.name = name
        self.logo_url = logo_url
        self.subName = subName
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: BankModel, rhs: BankModel) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    private let identifier = UUID()
}
