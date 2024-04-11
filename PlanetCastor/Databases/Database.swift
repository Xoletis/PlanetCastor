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
    let ressourcesTable = Table("ressources")
    let planetatmospheretable = Table("planet_atmosphere")
    let planetressourcetable = Table("planet_ressource")
    let biodivType = Table("biodiv_type")
    let biodivSpacies = Table("biodiv_spacies")
    
    
    let planetId = Expression<Int>("planet_id")
    let atmosphereId = Expression<Int>("atmosphere_id")
    let resourceId = Expression<Int>("ressource_id")
    let linkAPId = Expression<Int>("linkap_id")
    let linkRPId = Expression<Int>("linkrp_id")
    
    let type = Expression<String>("type")
    let diametre = Expression<Int>("diametre")
    let continent = Expression<Int>("continent")
    let temperature = Expression<Int>("temperature")
    let humidite = Expression<Int>("humidite")
    let pression = Expression<Int>("pression")
    
    let atm_name = Expression<String>("atm_name")
    let res_name = Expression<String>("res_name")
    
    let linkAP_planetId = Expression<Int>("linkAP_planetId")
    let linkAP_athmosphereId = Expression<Int>("linkAP_athmosphereId")
    
    let linkRP_planetId = Expression<Int>("linkRP_planetId")
    let linkRP_ressourceId = Expression<Int>("linkRP_ressourceId")
    
    let biodiv_ID = Expression<Int>("biodiv_ID")
    let biodiv_name = Expression<String>("biodiv_name")
    let biodiv_type = Expression<String>("biodiv_type")
    
    let biodivspacies_id = Expression<Int>("biodiv_spacies_id")
    let biodivspacies_type = Expression<String>("biodiv_spacies_type")
    
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
        
        if updateTable || !tableExists(tableName: "planets") || !tableExists(tableName: "athmosphere") ||  !tableExists(tableName: "planet_atmosphere") ||  !tableExists(tableName: "ressources") ||  !tableExists(tableName: "planet_ressource") || !tableExists(tableName: "aquatique_type") || !tableExists(tableName: "biodiv_spacies_img"){
            createOrDeleteTable(table: self.planetsTable.drop())
            createOrDeleteTable(table: self.athmosphereTabe.drop())
            createOrDeleteTable(table: self.planetatmospheretable.drop())
            createOrDeleteTable(table: self.ressourcesTable.drop())
            createOrDeleteTable(table: self.planetressourcetable.drop())
            createOrDeleteTable(table: self.biodivType.drop())
            createOrDeleteTable(table: self.biodivSpacies.drop())
            
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
            
            createAthmosphere(name: "neon")
            createAthmosphere(name: "argon")
            createAthmosphere(name: "dihydrogene")
            createAthmosphere(name: "helium")
            createAthmosphere(name: "diazote")
            createAthmosphere(name: "dioxygene")
            createAthmosphere(name: "sodium")
            createAthmosphere(name: "dioxyde de carbone")
            createAthmosphere(name: "methane")
            
            createOrDeleteTable(table: self.planetatmospheretable.create{ (table) in
                table.column(self.linkAPId, primaryKey: true)
                table.column(self.linkAP_planetId)
                table.column(self.linkAP_athmosphereId)
            })
            
            createOrDeleteTable(table: self.ressourcesTable.create{ (table) in
                table.column(self.resourceId, primaryKey: true)
                table.column(self.res_name)
            })
            
            createRessource(name: "bois")
            createRessource(name: "charbon")
            createRessource(name: "fer")
            createRessource(name: "cuivre")
            createRessource(name: "plomb")
            createRessource(name: "or")
            createRessource(name: "pierre")
            createRessource(name: "petrole")
            createRessource(name: "eau douce")
            
            createOrDeleteTable(table: self.planetressourcetable.create{ (table) in
                table.column(self.linkRPId, primaryKey: true)
                table.column(self.linkRP_planetId)
                table.column(self.linkRP_ressourceId)
            })
            
            createOrDeleteTable(table: self.biodivType.create{ (table) in
                table.column(self.biodiv_ID, primaryKey: true)
                table.column(self.biodiv_name)
                table.column(self.biodiv_type)
            })
            
            createBiodiv(name: "Craniates non tétrapodes", Type: "aquatique")
            createBiodiv(name: "Céphalopodes", Type: "aquatique")
            createBiodiv(name: "Euselachii", Type: "aquatique")
            createBiodiv(name: "Cétacés", Type: "aquatique")
            createBiodiv(name: "Crustacés", Type: "aquatique")
            createBiodiv(name: "Cryptodira", Type: "aquatique")
            createBiodiv(name: "Mollusques", Type: "aquatique")
            createBiodiv(name: "Hétérokontophytes", Type: "aquatique")
            
            let commetuveux = self.planetsTable.insert(self.type<-"aride", self.diametre<-5000, self.continent<-8, self.temperature<-45, self.humidite<-89, self.pression<-6)
            do {
                try self.database.run(commetuveux)
            } catch {
                print("error")
            }
            self.addAtmosphere(atmosphereID: 5, planetID: 1)
            self.addRessource(ressourceID: 4, planetID: 1)
            
            createOrDeleteTable(table: self.biodivSpacies.create{ (table) in
                table.column(self.biodivspacies_id, primaryKey: true)
                table.column(self.biodivspacies_type)
            })
            
            AddAllBiodivSpacies()
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
    
    func createRessource(name: String){
        let insert = self.ressourcesTable.insert(self.res_name <- name)
        do{
            try self.database.run(insert)
        }catch{
            print(error)
        }
    }
    
    func createBiodiv(name : String, Type : String){
        let insert = self.biodivType.insert(self.biodiv_name <- name, self.biodiv_type <- Type)
        do{
            try self.database.run(insert)
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
        
        let linkAP_Query = self.planetsTable
            .join(self.planetatmospheretable, on: self.planetId == self.linkAP_planetId)
            .join(self.athmosphereTabe, on: self.atmosphereId == self.linkAP_athmosphereId)
            .filter(self.planetId == id)
        
        let linkRP_Query = self.planetsTable
            .join(self.planetressourcetable, on: self.planetId == self.linkRP_planetId)
            .join(self.ressourcesTable, on: self.resourceId == self.linkRP_ressourceId)
            .filter(self.planetId == id)
        
        do {
            let planets = try self.database.prepare(self.planetsTable)
            for planet in planets {
                if(planet[self.planetId] == id){
                    text += "id: \(planet[self.planetId]), type: \(planet[self.type]), diamètre: \(planet[self.diametre]), contient: \(planet[self.continent]), temperature: \(planet[self.temperature]), humidité: \(planet[self.humidite]), pression: \(planet[self.pression])"
                }
            }
            
            text += ", atmospheres : "
            
            for row in try self.database.prepare(linkAP_Query) {
                let name = try row.get(self.atm_name)
                text += "\(name), "
            }
            
            text += " ressources : "
            
            for row in try self.database.prepare(linkRP_Query) {
                let name = try row.get(self.res_name)
                text += "\(name), "
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
    
    func addRessource(ressourceID : Int, planetID : Int){
        let insertElement = self.planetressourcetable.insert(self.linkRP_ressourceId <- ressourceID, self.linkRP_planetId <- planetID)
        do{
            try self.database.run(insertElement)
        }catch{
            print(error)
        }
        
        showPlanet(id: planetID)
    }
    
    func removeRessource(ressourceID : Int, planetID : Int){
        let planet = self.planetressourcetable.filter(self.linkRP_planetId == planetID && self.linkRP_ressourceId == ressourceID);
        let planetDelete = planet.delete();
        do{
            try self.database.run(planetDelete)
        }catch{
            print(error)
        }
        
        showPlanet(id: planetID)
    }
    
    func getPlanetParameter<V : Value>(id : Int, parametre : Expression<V>) -> V? {
        let planet = self.planetsTable.filter(self.planetId == id);
        var type : V? = nil
        do{
            for row in try self.database.prepare(planet) {
                type = try row.get(parametre)
            }
        }catch{
            print(error)
        }
        
        return type
    }
    
    func getBiodivType(type : String) -> [String]{
        var texts: [String] = []
        
        let biodiv = self.biodivType.filter(self.biodiv_type == type)
        
        do{
            for row in try self.database.prepare(biodiv) {
                let name = try row.get(self.biodiv_name)
                texts.append(name)
            }
        }catch{
            print(error)
        }
        
        return texts
    }
    
    func getPlanetAthmosphere(id : Int) -> [String]{
        
        var atmospheres: [String] = []
        
        let linkAP_Query = self.planetsTable
            .join(self.planetatmospheretable, on: self.planetId == self.linkAP_planetId)
            .join(self.athmosphereTabe, on: self.atmosphereId == self.linkAP_athmosphereId)
            .filter(self.planetId == id)
        
        do{
            for row in try self.database.prepare(linkAP_Query) {
                let name = try row.get(self.atm_name)
                atmospheres.append(name)
            }
        }catch{
            print(error)
        }
        
        return atmospheres
    }
    
    func getPlanetRessource(id : Int) -> [String]{
        
        var ressources: [String] = []
        
        let linkRP_Query = self.planetsTable
            .join(self.planetressourcetable, on: self.planetId == self.linkRP_planetId)
            .join(self.ressourcesTable, on: self.resourceId == self.linkRP_ressourceId)
            .filter(self.planetId == id)
        
        do{
            for row in try self.database.prepare(linkRP_Query) {
                let name = try row.get(self.res_name)
                ressources.append(name)
            }
        }catch{
            print(error)
        }
        
        return ressources
    }
    
    func AddAllBiodivSpacies(){
        for _ in 1...24{
            createBiodivSpacies(Type: "Craniates non tétrapodes")
        }
        for _ in 1...24{
            createBiodivSpacies(Type: "Céphalopodes")
        }
    }
    
    func createBiodivSpacies(Type : String){
        let insert = self.biodivSpacies.insert( self.biodivspacies_type <- Type)
        do{
            try self.database.run(insert)
        }catch{
            print(error)
        }
    }
    
    func getBiodivSpacies(type : String) -> [String]{
        var texts: [String] = []
        
        let biodiv = self.biodivSpacies.filter(self.biodivspacies_type == type)
        
        do{
            for row in try self.database.prepare(biodiv) {
                let name = try row.get(self.biodivspacies_id)
                texts.append("bs_\(name)")
            }
        }catch{
            print(error)
        }
        
        return texts
    }
    
}
