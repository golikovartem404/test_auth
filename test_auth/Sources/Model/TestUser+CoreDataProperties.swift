//
//  TestUser+CoreDataProperties.swift
//  test_auth
//
//  Created by User on 02.01.2023.
//
//

import Foundation
import CoreData


extension TestUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TestUser> {
        return NSFetchRequest<TestUser>(entityName: "TestUser")
    }

    @NSManaged public var email: String?
    @NSManaged public var password: String?

}

extension TestUser : Identifiable {

}
