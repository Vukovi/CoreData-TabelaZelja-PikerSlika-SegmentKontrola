//
//  Item+CoreDataClass.swift
//  Lista zelja
//
//  Created by Vuk on 3/20/17.
//  Copyright © 2017 Vuk. All rights reserved.
//

import Foundation
import CoreData


public class Item: NSManagedObject {
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        self.created = NSDate()
    }

}
