//
//  List+CoreDataProperties.swift
//  
//
//  Created by Vicente Cantu Garcia on 16/11/17.
//
//

import Foundation
import CoreData


extension List {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<List> {
        return NSFetchRequest<List>(entityName: "List")
    }

    @NSManaged public var name: String?
    @NSManaged public var category: String?
    @NSManaged public var products: NSSet?
    @NSManaged public var history: History?
    @NSManaged public var users: User?

}

// MARK: Generated accessors for products
extension List {

    @objc(addProductsObject:)
    @NSManaged public func addToProducts(_ value: Product)

    @objc(removeProductsObject:)
    @NSManaged public func removeFromProducts(_ value: Product)

    @objc(addProducts:)
    @NSManaged public func addToProducts(_ values: NSSet)

    @objc(removeProducts:)
    @NSManaged public func removeFromProducts(_ values: NSSet)

}
