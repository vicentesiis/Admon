//
//  User+CoreDataProperties.swift
//  
//
//  Created by Vicente Cantu Garcia on 16/11/17.
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
    @NSManaged public var lists: List?

}
