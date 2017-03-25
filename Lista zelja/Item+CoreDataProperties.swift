//
//  Item+CoreDataProperties.swift
//  Lista zelja
//
//  Created by Vuk on 3/20/17.
//  Copyright © 2017 Vuk. All rights reserved.
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item");
    }

    @NSManaged public var created: NSDate?
    @NSManaged public var details: String?
    @NSManaged public var price: Double
    @NSManaged public var title: String?
    @NSManaged public var toimage: Image?
    @NSManaged public var toItemType: ItemType?
    @NSManaged public var toStore: Store?

}
