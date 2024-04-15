//
//  ImageSpawn.swift
//  PlanetCastor
//
//  Created by Ivan Rocque on 11/04/2024.
//

import Foundation
import UIKit
import SQLite

struct Location {
    var name: String
    var x: Double
    var y: Double
}

class ImageSpawns{
    
    static let shared = ImageSpawns()
    
    var images : [Location] = []
    
    init(){
        
    }
    
    func addLocation(name: String, x: Double, y: Double){
        images.append(Location(name: name, x: x, y: y))
    }
}
