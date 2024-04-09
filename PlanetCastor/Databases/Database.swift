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
    
    let updateTable = true
    
    let planetsTable = Table("planets")
    let athmosphereTabe = Table("athmosphere")
    let planetatmospheretable = Table("planet_atmosphere")
    
    
    let planetId = Expression<Int>("planet_id")
    let atmosphereId = Expression<Int>("atmosphere_id")
    let planetatmosphereId = Expression<Int>("linkap_id")
    
    let type = Expression<String>("type")
    let diametre = Expression<Int>("diametre")
    let continent = Expression<Int>("continent")
    let temperature = Expression<Int>("temperature")
    let humidite = Expression<Int>("humidite")
    let pression = Expression<Int>("pression")
    
    let atm_name = Expression<String>("atm_name")
    
    let linkAP_planetId = Expression<Int>("linkAP_planetId")
    let linkAP_athmosphereId = Expression<Int>("linkAP_athmosphereId")
    
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
        
        if updateTable || !tableExists(tableName: "planets") || !tableExists(tableName: "athmosphere") ||  !tableExists(tableName: "planet_atmosphere"){
            createOrDeleteTable(table: self.planetsTable.drop())
            createOrDeleteTable(table: self.athmosphereTabe.drop())
            createOrDeleteTable(table: self.planetatmospheretable.drop())
            
            createOrDeleteTable(table: self.planetsTable.create{ (table) in
                table.column(self.planetId, primaryKey: true)
                table.column(self.type)
                table.column(self.continent, defaultValue: 7)
                table.column(self.diametre, defaultValue: 12742)
                table.column(self.temperature, defaultValue: 15)
                table.column(self.humidite, defaultValue: 30)
                table.column(self.pression, defaultValue: 1)
            })
            
            createOrDeleteTable(table: self.athmosphereTabe.create{ (table) in
                table.column(self.atmosphereId, primaryKey: true)
                table.column(self.atm_name)
            })
            
            createAthmosphere(name: "néon")
            createAthmosphere(name: "argon")
            createAthmosphere(name: "dihydrogène")
            createAthmosphere(name: "hlium")
            createAthmosphere(name: "diazote")
            createAthmosphere(name: "dioxygène")
            createAthmosphere(name: "sodium")
            createAthmosphere(name: "dioxyde de carbone")
            createAthmosphere(name: "méthane")
            
            createOrDeleteTable(table: self.planetatmospheretable.create{ (table) in
                table.column(self.planetatmosphereId, primaryKey: true)
                table.column(self.linkAP_planetId)
                table.column(self.linkAP_athmosphereId)
            })
            
            /*do{
                let athmospheres = try self.database.prepare(self.athmosphereTabe)
                for athmosphere in athmospheres {
                        print("id: \(athmosphere[self.id]), name: \(athmosphere[self.name])")
                }
            }catch{
                print(error)
            }*/
            
        }
    }
    
    func createAthmosphere(name: String){
        let insertAthmosphere = self.athmosphereTabe.insert(self.atm_name <- name)
        do{
            try self.database.run(insertAthmosphere)
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
        let planet = self.planetsTable.filter(self.planetId == id)
        let updatePlanet = planet.update(self.type <- type)
        updateDatabase(method: updatePlanet)
    }
    
    func setDiametre(diametre: Int, id: Int){
        let planet = self.planetsTable.filter(self.planetId == id)
        let updatePlanet = planet.update(self.diametre <- diametre)
        updateDatabase(method: updatePlanet)
    }
    
    func setContinent(continent: Int, id: Int){
        let planet = self.planetsTable.filter(self.planetId == id)
        let updatePlanet = planet.update(self.continent <- continent)
        updateDatabase(method: updatePlanet)
    }
    
    func setTemperature(temperature: Int, id: Int){
        let planet = self.planetsTable.filter(self.planetId == id)
        let updatePlanet = planet.update(self.temperature <- temperature)
        updateDatabase(method: updatePlanet)
    }
    
    func setHumidite(humidite: Int, id: Int){
        let planet = self.planetsTable.filter(self.planetId == id)
        let updatePlanet = planet.update(self.humidite <- humidite)
        updateDatabase(method: updatePlanet)
    }
    
    func setPression(pression: Int, id: Int){
        let planet = self.planetsTable.filter(self.planetId == id)
        let updatePlanet = planet.update(self.pression <- pression)
        updateDatabase(method: updatePlanet)
    }
    
    func showPlanet(id: Int){
        var text = ""
        let query = self.planetsTable
            .join(self.planetatmospheretable, on: self.planetId == self.linkAP_planetId)
            .join(self.athmosphereTabe, on: self.atmosphereId == self.linkAP_athmosphereId)
            .filter(self.planetId == id)
        
        do {
            let planets = try self.database.prepare(self.planetsTable)
            for planet in planets {
                if(planet[self.planetId] == id){
                    text += "id: \(planet[self.planetId]), type: \(planet[self.type]), diamètre: \(planet[self.diametre]), contient: \(planet[self.continent]), temperature: \(planet[self.temperature]), humidité: \(planet[self.humidite]), pression: \(planet[self.pression])"
                }
            }
            
            text += ", atmospheres : "
            
            for row in try self.database.prepare(query) {
                let atmosphereName = try row.get(self.atm_name)
                text += "\(atmosphereName), "
            }
        } catch {
            print("Erreur lors de l'exécution de la requête: \(error)")
        }
        
        print(text)
    }
    
    func getLastId() -> Int{
       var id = 1
        do{
            let planets = try self.database.prepare(self.planetsTable)
            for planet in planets {
                id = planet[self.planetId]
            }
        }catch{
            print(error)
        }
        return id;
    }
    
    func deleteByID(id: Int){
        let planet = self.planetsTable.filter(self.planetId == id);
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
    
    func createOrDeleteTable(table: String){
        do{
            try self.database.run(table)
        }catch{
            print(error)
        }
    }
    
    func tableExists(tableName: String) -> Bool {
        do {
            let rowCount = try self.database.scalar("SELECT count(*) FROM sqlite_master WHERE type = 'table' AND name = ?", tableName) as! Int64
            return rowCount > 0
        } catch {
            print("Erreur lors de la vérification de l'existence de la table : \(error)")
            return false
        }
    }
    
    func addAtmosphere(atmosphereID : Int, planetID : Int){
        let insertElement = self.planetatmospheretable.insert(self.linkAP_athmosphereId <- atmosphereID, self.linkAP_planetId <- planetID)
        do{
            try self.database.run(insertElement)
        }catch{
            print(error)
        }
        
        showPlanet(id: planetID)
    }
    
    func removeAtmosphere(atmosphereID : Int, planetID : Int){
        let planet = self.planetatmospheretable.filter(self.linkAP_planetId == planetID && self.linkAP_athmosphereId == atmosphereID);
        let planetDelete = planet.delete();
        do{
            try self.database.run(planetDelete)
        }catch{
            print(error)
        }
        
        showPlanet(id: planetID)
    }
}
