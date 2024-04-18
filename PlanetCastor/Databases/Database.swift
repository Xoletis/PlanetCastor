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
    
    let updateTable = false
    
    let planetsTable = Table("planets")
    let athmosphereTabe = Table("athmosphere")
    let ressourcesTable = Table("ressources")
    let caracterTable = Table("caracter")
    let planetatmospheretable = Table("planet_atmosphere")
    let planetressourcetable = Table("planet_ressource")
    let biodivType = Table("biodiv_type")
    let biodivSpacies = Table("biodiv_spacies")
    let biodivInPlanet = Table("biodiv_planet")
    let linkCP = Table("Link_CP")
    
    
    let planetId = Expression<Int>("planet_id")
    let atmosphereId = Expression<Int>("atmosphere_id")
    let resourceId = Expression<Int>("ressource_id")
    let carId = Expression<Int>("CarID");
    let linkAPId = Expression<Int>("linkap_id")
    let linkRPId = Expression<Int>("linkrp_id")
    let linkCPId = Expression<Int>("linkcp_ID")
    
    let planetname = Expression<String>("name")
    let planetdesc = Expression<String>("desc")
    let type = Expression<String>("type")
    let diametre = Expression<Int>("diametre")
    let continent = Expression<Int>("continent")
    let temperature = Expression<Int>("temperature")
    let humidite = Expression<Int>("humidite")
    let pression = Expression<Int>("pression")
    let habitantName = Expression<String>("habitant_name")
    let color_r = Expression<Int>("color_r")
    let color_g = Expression<Int>("color_g")
    let color_b = Expression<Int>("color_b")
    let langue = Expression<String>("langue")
    let aspect = Expression<String>("aspect")
    let politique = Expression<String>("politique")
    let tech = Expression<String>("tech")
    let moon = Expression<Int>("moon")
    let starname = Expression<String>("star_name")
    let startype = Expression<Int>("star_type")
    
    let atm_name = Expression<String>("atm_name")
    let res_name = Expression<String>("res_name")
    let car_name = Expression<String>("car_name")
    
    let linkAP_planetId = Expression<Int>("linkAP_planetId")
    let linkAP_athmosphereId = Expression<Int>("linkAP_athmosphereId")
    
    let linkRP_planetId = Expression<Int>("linkRP_planetId")
    let linkRP_ressourceId = Expression<Int>("linkRP_ressourceId")
    
    let linkCP_planetID = Expression<Int>("linkCP_planet")
    let linkCP_caracterID = Expression<Int>("linkCP_caracter")
    
    let biodiv_ID = Expression<Int>("biodiv_ID")
    let biodiv_name = Expression<String>("biodiv_name")
    let biodiv_type = Expression<String>("biodiv_type")
    
    let biodivspacies_id = Expression<Int>("biodiv_spacies_id")
    let biodivspacies_type = Expression<String>("biodiv_spacies_type")
    
    let BIP_id = Expression<Int>("BIP_id")
    let BIP_img = Expression<String>("BIP_img")
    let BIP_X = Expression<Int>("BIP_x")
    let BIP_Y = Expression<Int>("BIP_Y")
    let BIP_planet = Expression<Int>("BIP_planet")
    
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
        
        if updateTable || !tableExists(tableName: "planets") || !tableExists(tableName: "athmosphere") ||  !tableExists(tableName: "planet_atmosphere") ||  !tableExists(tableName: "ressources") ||  !tableExists(tableName: "planet_ressource") || !tableExists(tableName: "biodiv_type") || !tableExists(tableName: "biodiv_spacies") || !tableExists(tableName: "biodiv_planet") || !tableExists(tableName: "caracter") || !tableExists(tableName: "Link_CP"){
            
            print("reset")
            
            createOrDeleteTable(table: self.planetsTable.drop())
            createOrDeleteTable(table: self.athmosphereTabe.drop())
            createOrDeleteTable(table: self.planetatmospheretable.drop())
            createOrDeleteTable(table: self.ressourcesTable.drop())
            createOrDeleteTable(table: self.planetressourcetable.drop())
            createOrDeleteTable(table: self.biodivType.drop())
            createOrDeleteTable(table: self.biodivSpacies.drop())
            createOrDeleteTable(table: self.biodivInPlanet.drop())
            createOrDeleteTable(table: self.caracterTable.drop())
            createOrDeleteTable(table: self.linkCP.drop())
            
            createOrDeleteTable(table: self.planetsTable.create{ (table) in
                table.column(self.planetId, primaryKey: true)
                table.column(self.planetname, defaultValue: "Terre")
                table.column(self.planetdesc, defaultValue: "Ecrivez votre description")
                table.column(self.type)
                table.column(self.continent, defaultValue: 7)
                table.column(self.diametre, defaultValue: 12742)
                table.column(self.temperature, defaultValue: 15)
                table.column(self.humidite, defaultValue: 30)
                table.column(self.pression, defaultValue: 1)
                table.column(self.habitantName, defaultValue: "Humain")
                table.column(self.color_r, defaultValue: 0)
                table.column(self.color_g, defaultValue: 0)
                table.column(self.color_b, defaultValue: 0)
                table.column(self.langue, defaultValue: "Français")
                table.column(self.aspect, defaultValue: "Humanoïde")
                table.column(self.politique, defaultValue: "Ploutocratie")
                table.column(self.tech, defaultValue: "Antiquité")
                table.column(self.moon, defaultValue: 1)
                table.column(self.starname, defaultValue: "Soleil")
                table.column(self.startype, defaultValue: 1)
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
            
            createOrDeleteTable(table: self.caracterTable.create{ (table) in
                table.column(self.carId, primaryKey: true)
                table.column(self.car_name)
            })
            
            createCaractere(name: "calme")
            createCaractere(name: "colerique")
            createCaractere(name: "altruiste")
            createCaractere(name: "energique")
            createCaractere(name: "sage")
            createCaractere(name: "orgueilleux")
            createCaractere(name: "avenant")
            createCaractere(name: "craintif")
            createCaractere(name: "respectueux")
            createCaractere(name: "brave")
            createCaractere(name: "cruel")
            createCaractere(name: "emotifs")
            createCaractere(name: "feignant")
            createCaractere(name: "gourmand")
            
            createOrDeleteTable(table: self.linkCP.create{ (table) in
                table.column(self.linkCPId, primaryKey: true)
                table.column(self.linkCP_planetID)
                table.column(self.linkCP_caracterID)
            })
            
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
            
            createOrDeleteTable(table: self.biodivSpacies.create{ (table) in
                table.column(self.biodivspacies_id, primaryKey: true)
                table.column(self.biodivspacies_type)
            })
            
            AddAllBiodivSpacies()
            
            createOrDeleteTable(table: self.biodivInPlanet.create{ (table) in
                table.column(self.BIP_id, primaryKey: true)
                table.column(self.BIP_img)
                table.column(self.BIP_X)
                table.column(self.BIP_Y)
                table.column(self.BIP_planet)
            })
            
            createPlanetesBase()
        }
        
        deletePlanetIfTypeNull()
    }
    
    func createPlanetesBase(){
        let terre = self.planetsTable.insert(self.type<-"terrestre", self.diametre<-12742, self.continent<-7, self.temperature<-15, self.humidite<-30, self.pression<-1)
        do {
            try self.database.run(terre)
        } catch {
            print("error")
        }
        self.addAtmosphere(atmosphereID: 1, planetID: 1)
        self.addAtmosphere(atmosphereID: 2, planetID: 1)
        self.addAtmosphere(atmosphereID: 3, planetID: 1)
        self.addAtmosphere(atmosphereID: 4, planetID: 1)
        self.addAtmosphere(atmosphereID: 5, planetID: 1)
        self.addAtmosphere(atmosphereID: 6, planetID: 1)
        self.addAtmosphere(atmosphereID: 8, planetID: 1)
        self.addAtmosphere(atmosphereID: 9, planetID: 1)
        
        self.addRessource(ressourceID: 1, planetID: 1)
        self.addRessource(ressourceID: 2, planetID: 1)
        self.addRessource(ressourceID: 3, planetID: 1)
        self.addRessource(ressourceID: 4, planetID: 1)
        self.addRessource(ressourceID: 5, planetID: 1)
        self.addRessource(ressourceID: 6, planetID: 1)
        self.addRessource(ressourceID: 7, planetID: 1)
        self.addRessource(ressourceID: 8, planetID: 1)
        self.addRessource(ressourceID: 9, planetID: 1)
        
        self.addSpaciesOnPlanet(planet: 1, img: "bs_1", x: 410/2, y: 939/2)
        
        
        let naboo = self.planetsTable.insert(self.type<-"marecageuse", self.diametre<-12120, self.continent<-1, self.temperature<-20, self.humidite<-40, self.pression<-1, self.planetname<-"Naboo")
        do {
            try self.database.run(naboo)
        } catch {
            print("error")
        }
        self.addAtmosphere(atmosphereID: 1, planetID: 2)
        self.addAtmosphere(atmosphereID: 2, planetID: 2)
        self.addAtmosphere(atmosphereID: 3, planetID: 2)
        self.addAtmosphere(atmosphereID: 4, planetID: 2)
        self.addAtmosphere(atmosphereID: 5, planetID: 2)
        self.addAtmosphere(atmosphereID: 6, planetID: 2)
        self.addAtmosphere(atmosphereID: 8, planetID: 2)
        self.addAtmosphere(atmosphereID: 9, planetID: 2)
        
        self.addRessource(ressourceID: 1, planetID: 2)
        self.addRessource(ressourceID: 9, planetID: 2)
        
        self.addSpaciesOnPlanet(planet: 2, img: "bs_1", x: 410/2, y: 939/2)
    }
    
    func deletePlanetIfTypeNull(){
        let planet = self.planetsTable.filter(self.type == "null")
        let planetDelet = planet.delete()
        do{
            try self.database.run(planetDelet)
        }catch{
            print(error)
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
    
    func createCaractere(name: String){
        let insert = self.caracterTable.insert(self.car_name <- name)
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
    
    func setPlanetParameter<V : Value>(id : Int, parametre : Expression<V>, value : V) {
        let planet = self.planetsTable.filter(self.planetId == id)
        let updatePlanet = planet.update(parametre <- value)
        updateDatabase(method: updatePlanet)
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
    }
    
    func removeAtmosphere(atmosphereID : Int, planetID : Int){
        let planet = self.planetatmospheretable.filter(self.linkAP_planetId == planetID && self.linkAP_athmosphereId == atmosphereID);
        let planetDelete = planet.delete();
        do{
            try self.database.run(planetDelete)
        }catch{
            print(error)
        }
    }
    
    func removeLastPlanet(){
        let planet = self.planetsTable.filter(self.planetId == getLastId())
        
        print(planet)
        
        let planetDelete = planet.delete();
        do{
            try self.database.run(planetDelete)
        }catch{
            print(error)
        }
    }
    
    func addRessource(ressourceID : Int, planetID : Int){
        let insertElement = self.planetressourcetable.insert(self.linkRP_ressourceId <- ressourceID, self.linkRP_planetId <- planetID)
        do{
            try self.database.run(insertElement)
        }catch{
            print(error)
        }
    }
    
    func removeRessource(ressourceID : Int, planetID : Int){
        let planet = self.planetressourcetable.filter(self.linkRP_planetId == planetID && self.linkRP_ressourceId == ressourceID);
        let planetDelete = planet.delete();
        do{
            try self.database.run(planetDelete)
        }catch{
            print(error)
        }
    }
    
    func addCar(carID : Int, planetID : Int){
        let insertElement = self.linkCP.insert(self.linkCP_caracterID <- carID, self.linkCP_planetID <- planetID)
        do{
            try self.database.run(insertElement)
        }catch{
            print(error)
        }
    }
    
    func removecar(carID : Int, planetID : Int){
        let planet = self.linkCP.filter(self.linkCP_planetID == planetID && self.linkCP_caracterID == carID);
        let planetDelete = planet.delete();
        do{
            try self.database.run(planetDelete)
        }catch{
            print(error)
        }
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
    
    func getPlanetCar(id : Int) -> [String]{
        
        var atmospheres: [String] = []
        
        let linkAP_Query = self.planetsTable
            .join(self.linkCP, on: self.planetId == self.linkCP_planetID)
            .join(self.caracterTable, on: self.carId == self.linkCP_caracterID)
            .filter(self.planetId == id)
        
        do{
            for row in try self.database.prepare(linkAP_Query) {
                let name = try row.get(self.car_name)
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
        for _ in 1...14{
            createBiodivSpacies(Type: "Cétacés")
        }
        for _ in 1...14{
            createBiodivSpacies(Type: "Euselachii")
        }
        for _ in 1...12{
            createBiodivSpacies(Type: "Céphalopodes")
        }
        for _ in 1...10{
            createBiodivSpacies(Type: "Crustacés")
        }
        for _ in 1...10{
            createBiodivSpacies(Type: "Cryptodira")
        }
        for _ in 1...14{
            createBiodivSpacies(Type: "Mollusques")
        }
        for _ in 1...18{
            createBiodivSpacies(Type: "Hétérokontophytes")
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
    
    func addSpaciesOnPlanet(planet : Int, img : String, x : Int, y : Int){
        let insert = self.biodivInPlanet.insert(self.BIP_planet <- planet, self.BIP_img <- img, self.BIP_X <- x, self.BIP_Y <- y)
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
    
    func getBiodivOnPlanet(id : Int) -> [Location]{
        var locs : [Location] = []
        
        let table = self.planetsTable
            .join(self.biodivInPlanet, on: self.planetId == self.BIP_planet)
            .filter(self.planetId == id)
        
        do{
            for row in try self.database.prepare(table) {
                var loc = Location(name: "", x: 0, y: 0)
                loc.name = try row.get(self.BIP_img)
                loc.x = Double(try row.get(self.BIP_X))
                loc.y = Double(try row.get(self.BIP_Y))
                locs.append(loc)
            }
        }catch{
            print(error)
        }
        
        return locs
    }
}
