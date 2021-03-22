//
//  Bank+CoreDataClass.swift
//  
//
//  Created by sofien Benharchache on 22/03/2021.
//
//

import Foundation
import CoreData

extension Bank {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Bank> {
        return NSFetchRequest<Bank>(entityName: "Bank")
    }

    @NSManaged public var id: Int16         /* Bank identifier */
    @NSManaged public var name: String?     /* Local bank name  */
    @NSManaged public var logo_url: String? /* Logo bank url */
    @NSManaged public var banks: BankGlobalGroup?
}

@objc(Bank)
public class Bank: NSManagedObject, Codable  {
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case logo_url = "logo_url"
    }

    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(logo_url, forKey: .logo_url)
    }

    // MARK: - Decodable
    required convenience public init(from decoder: Decoder) throws {
        guard
            let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Bank", in: context)
        else {
            fatalError("decode failure")
        }
        // Super init of the NSManagedObject
        self.init(entity: entity, insertInto: context)

        let values = try decoder.container(keyedBy: CodingKeys.self)
        do {
            id = try values.decodeIfPresent(Int16.self, forKey: .id)!
            name = try values.decodeIfPresent(String.self, forKey: .name)
            logo_url = try values.decodeIfPresent(String.self, forKey: .logo_url)
        } catch {
            print ("error")
        }
    }
}

