//
//  Users+CoreDataProperties.swift
//  CoreData1
//
//  Created by App-Designer2 . on 31.08.19.
//  Copyright © 2019 App-Designer2 . All rights reserved.
//
//

import Foundation
import CoreData


extension Users {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users")
    }

    @NSManaged public var name: String?
    @NSManaged public var date: Date?

}
