//
//  Human+CoreDataProperties.swift
//  NeVK
//
//  Created by Mikhail Papullo on 1/20/22.
//
//

import Foundation
import CoreData


extension Human {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Human> {
        return NSFetchRequest<Human>(entityName: "Human")
    }

    @NSManaged public var name: String?
    @NSManaged public var birthday: Date?
    @NSManaged public var age: Int64

}

extension Human : Identifiable {

}
