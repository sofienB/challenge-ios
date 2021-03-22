//
//  UIImageView+Extension.swift
//  BankApp
//
//  Created by sofien Benharchache on 21/03/2021.
//

import UIKit
import CoreData

extension UIImageView {
    func load(url: URL, withPlaceholder placeholder:String? = nil) {
        DispatchQueue.global().async { [weak self] in
            // Try to get data from local storage
            let imageRequest: NSFetchRequest<ImageEntity> = ImageEntity.fetchImage(withUrl: url)
            do {
                let images = try PersistenceService.context.fetch(imageRequest)
                if !images.isEmpty {
                    if let imageEntity = images.first,
                       let imageData = imageEntity.image,
                       let image = UIImage(data: imageData) {
                        DispatchQueue.main.async {
                            self?.image = image
                        }
                        return
                    }
                }
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
            do {
                URLSession.shared.dataTask(with: url) { [self] (data, response, error) in
                    // If no internet connection or url not working
                    if error != nil {
                        // Use placeholder image and finish.
                        if let placeholder = placeholder {
                            self?.setPlaceholder(name: placeholder)
                            return
                        }
                    }
                    
                    // Persistence using core data to store image and url.
                    ImageEntity.saveImage(data!, from:url)

                    if let image = UIImage(data: data!) {
                        DispatchQueue.main.async {
                                self?.image = image
                        }
                    }
                }.resume()

            }
        }
    }

    func setPlaceholder(name: String) {
        if let image = UIImage(named: name) {
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
