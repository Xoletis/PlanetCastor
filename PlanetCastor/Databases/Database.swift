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
    let diametre = Expression<Int>("diametre")
    let continent = Expression<Int>("continent")
    let temperature = Expression<Int>("temperature")
    let humidite = Expression<Int>("humidite")
    let pression = Expression<Int>("pression")
    
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
        let creatTable = self.planetsTable.create{ (table) in
            table.column(self.id, primaryKey: true)
            table.column(self.type)
            table.column(self.continent, defaultValue: 7)
            table.column(self.diametre, defaultValue: 12742)
            table.column(self.temperature, defaultValue: 15)
            table.column(self.humidite, defaultValue: 30)
            table.column(self.pression, defaultValue: 1)
        }
        //let creatTable = self.planetsTable.drop()
        do{
            try self.database.run(creatTable)
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
        updateDatabase(method: updatePlanet)
    }
    
    func setDiametre(diametre: Int, id: Int){
        let planet = self.planetsTable.filter(self.id == id)
        let updatePlanet = planet.update(self.diametre <- diametre)
        updateDatabase(method: updatePlanet)
    }
    
    func setContinent(continent: Int, id: Int){
        let planet = self.planetsTable.filter(self.id == id)
        let updatePlanet = planet.update(self.continent <- continent)
        updateDatabase(method: updatePlanet)
    }
    
    func showPlanet(id: Int){
        do{
            let planets = try self.database.prepare(self.planetsTable)
            for planet in planets {
                if(planet[self.id] == id){
                    print("id: \(planet[self.id]), type: \(planet[self.type]), diamètre: \(planet[self.diametre]), contient: \(planet[self.continent]), temperature: \(planet[self.temperature]), humidité: \(planet[self.humidite]), pression: \(planet[self.pression])")
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
    
    func deleteByID(id: Int){
        let planet = self.planetsTable.filter(self.id == id);
        let planetDelet = planet.delete();
        do{
            try self.database.run(planetDelet)
        }catch{
            print(error)
        }
    }
    
    func updateDatabase(method: Update){
        do{
            try self.database.run(method)
        }catch{
            print(error)
        }
        
        showPlanet(id: getLastId())
    }
}
