//
//  Dfunc+CoreDataProperties.swift
//  Honnmin
//
//  Created by 오현우 on 2022/09/08.
//
//

import Foundation
import CoreData


extension Dfunc {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dfunc> {
        return NSFetchRequest<Dfunc>(entityName: "Dfunc")
    }

    @NSManaged public var explain: String?
    @NSManaged public var fc: String?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var fr: String?

}

extension Dfunc : Identifiable {
    
   

}
