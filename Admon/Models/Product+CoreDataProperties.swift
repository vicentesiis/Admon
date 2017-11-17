//
//  Product+CoreDataProperties.swift
//  
//
//  Created by Vicente Cantu Garcia on 16/11/17.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var image: NSData?
    @NSManaged public var name: String?
    @NSManaged public var price: Double
    @NSManaged public var quantity: Int32
    @NSManaged public var list: List?

}
