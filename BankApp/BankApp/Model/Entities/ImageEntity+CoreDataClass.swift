//
//  ImageEntity+CoreDataClass.swift
//  
//
//  Created by sofien Benharchache on 22/03/2021.
//
//

import Foundation
import CoreData


extension ImageEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageEntity> {
        return NSFetchRequest<ImageEntity>(entityName: "ImageEntity")
    }
    
    @nonobjc public class func fetchImage(withUrl url: URL) -> NSFetchRequest<ImageEntity> {
        let request: NSFetchRequest<ImageEntity> = NSFetchRequest<ImageEntity>(entityName: "ImageEntity")
        request.predicate = NSPredicate(format: "url = %@", url as CVarArg)
        return request
    }
    
    @NSManaged public var image: Data?
    @NSManaged public var url: URL?
}

public class ImageEntity: NSManagedObject {

    class func saveImage(_ data:Data, from url: URL) {
        let imageEntity = NSEntityDescription.insertNewObject(forEntityName: "ImageEntity",
                                                            into: PersistenceService.context)
        imageEntity.setValue(data, forKey: "image")
        imageEntity.setValue(url, forKey: "url")
        PersistenceService.saveContext()
        
    }
}
