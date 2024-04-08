//
//  Planet+CoreDataProperties.swift
//  PlanetCastor
//
//  Created by Ivan Rocque on 08/04/2024.
//
//

import Foundation
import CoreData


extension Planet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Planet> {
        return NSFetchRequest<Planet>(entityName: "Planet")
    }

    @NSManaged public var name: String?
    @NSManaged public var type: String?

}

extension Planet : Identifiable {

}
