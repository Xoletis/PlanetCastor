//
//  Database.swift
//  PlanetCastor
//
//  Created by Ivan Rocque on 08/04/2024.
//

import Foundation
import UIKit
import SQLite


class Database{
    
    static let shared = Database()
    
    var database: Connection!
    
    let planetsTable = Table("planets")
    let id = Expression<Int>("id")
    let type = Expression<String>("type")
    
    init(){
        do{
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileURL = documentDirectory.appendingPathComponent("planets").appendingPathExtension("sqlite3")
            let database = try Connection(fileURL.path)
            self.database = database
        }catch{
            print(error)
        }
    }
    
    func createTable(){
        print ("Creat Table")
        
        let creatTable = self.planetsTable.create{ (table) in
            table.column(self.id, primaryKey: true)
            table.column(self.type)
        }
        
        do{
            try self.database.run(creatTable)
            print("Created Table")
        }catch{
            print(error)
        }
    }
    
    func createPlanet() -> Int{
        let insertPlanet = self.planetsTable.insert(self.type <- "null")
        do{
            try self.database.run(insertPlanet)
        }catch{
            print(error)
        }
        return getLastId()
    }
    
    func setType(type: String, id : Int){
        let planet = self.planetsTable.filter(self.id == id)
        let updatePlanet = planet.update(self.type <- type)
        do{
            try self.database.run(updatePlanet)
        }catch{
            print(error)
        }
        showPlanet(id: id)
    }
    
    func listPlanet(){
        do{
            let planets = try self.database.prepare(self.planetsTable)
            for planet in planets {
                print("planetId: \(planet[self.id]), type: \(planet[self.type])")
            }
        }catch{
            print(error)
        }
    }
    
    func showPlanet(id: Int){
        do{
            let planets = try self.database.prepare(self.planetsTable)
            for planet in planets {
                if(planet[self.id] == id){
                    print("planetId: \(planet[self.id]), type: \(planet[self.type])")
                }
            }
        }catch{
            print(error)
        }
    }
    
    func getLastId() -> Int{
       var id = 1
        do{
            let planets = try self.database.prepare(self.planetsTable)
            for planet in planets {
                id = planet[self.id]
            }
        }catch{
            print(error)
        }
        return id;
    }
}
