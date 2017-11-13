//
//  User+CoreDataProperties.swift
//  
//
//  Created by Vicente Cantu Garcia on 13/11/17.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var lastName: String?
    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var userName: String?
    @NSManaged public var history: History?
    @NSManaged public var products: NSSet?

}

// MARK: Generated accessors for products
extension User {

    @objc(addProductsObject:)
    @NSManaged public func addToProducts(_ value: Product)

    @objc(removeProductsObject:)
    @NSManaged public func removeFromProducts(_ value: Product)

    @objc(addProducts:)
    @NSManaged public func addToProducts(_ values: NSSet)

    @objc(removeProducts:)
    @NSManaged public func removeFromProducts(_ values: NSSet)

}
