//
//  ItemType+CoreDataProperties.swift
//  Lista zelja
//
//  Created by Vuk on 3/20/17.
//  Copyright © 2017 Vuk. All rights reserved.
//

import Foundation
import CoreData


extension ItemType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemType> {
        return NSFetchRequest<ItemType>(entityName: "ItemType");
    }

    @NSManaged public var type: String?
    @NSManaged public var toItem: Item?

}
