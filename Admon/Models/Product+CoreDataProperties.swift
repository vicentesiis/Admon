//
//  Product+CoreDataProperties.swift
//  
//
//  Created by Vicente Cantu Garcia on 13/11/17.
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
    @NSManaged public var history: History?
    @NSManaged public var users: NSSet?

}

// MARK: Generated accessors for users
extension Product {

    @objc(addUsersObject:)
    @NSManaged public func addToUsers(_ value: User)

    @objc(removeUsersObject:)
    @NSManaged public func removeFromUsers(_ value: User)

    @objc(addUsers:)
    @NSManaged public func addToUsers(_ values: NSSet)

    @objc(removeUsers:)
    @NSManaged public func removeFromUsers(_ values: NSSet)

}
