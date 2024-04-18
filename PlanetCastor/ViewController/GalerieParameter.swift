//
//  GalerieParameter.swift
//  PlanetCastor
//
//  Created by Anna Sarbiewski on 10/04/2024.
//

import Foundation
import UIKit

class GalerieParameter: UIViewController {
    
    @IBOutlet var buttonsShadow: [UIButton]!
    
    @IBOutlet var planeteParameter: [UILabel]!
    
    @IBOutlet weak var nomPlanete: UILabel!
    @IBOutlet weak var imagePlanete: UIImageView!
    @IBOutlet weak var typePlanete: UILabel!
    @IBOutlet weak var diametrePlanete: UILabel!
    @IBOutlet weak var continentsPlanete: UILabel!
    @IBOutlet weak var temperaturePlanete: UILabel!
    @IBOutlet weak var humiditePlanete: UILabel!
    @IBOutlet weak var pressionPlanete: UILabel!
    @IBOutlet weak var atmospherePlanete: UILabel!
    @IBOutlet weak var ressourcesPlanete: UILabel!
    
    var planetID = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        planetID = PlanetShow.shared.planetToShowId
        
        let data = Database.shared
        
        for button in buttonsShadow {
            button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.40).cgColor
            button.layer.shadowOpacity = 0.9
            button.layer.shadowOffset = CGSize(width: 1.5, height: 4.0)
            button.layer.shadowRadius = 2
            button.layer.cornerRadius = 4.0
        }
    
        if typePlanete != nil {
            for parameter in planeteParameter {
                parameter.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
                parameter.layer.borderWidth = 1.0
                parameter.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.40).cgColor
                parameter.layer.shadowOpacity = 0.9
                parameter.layer.shadowOffset = CGSize(width: 1.5, height: 4.0)
                parameter.layer.shadowRadius = 2
                parameter.layer.cornerRadius = 16.0
                parameter.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
            }
            
            nomPlanete.text = "Terre"
            
            let name = (data.getPlanetParameter(id: planetID, parametre: data.type)?.uppercased())!
            let namel = name.lowercased()
            let img = "Planete\(name.prefix(1) + (name.suffix(namel.count - 1)).lowercased())"
            
            imagePlanete.image = UIImage(named: img)
            
            let planetType = Database.shared.getPlanetParameter(id: planetID, parametre: Database.shared.type)?.uppercased();
            typePlanete.text = planetType

            let planetDiametre = Database.shared.getPlanetParameter(id: planetID, parametre: Database.shared.diametre);
            diametrePlanete.text = "\(String(describing: planetDiametre!)) km"
            
            let planetContinents = Database.shared.getPlanetParameter(id: planetID, parametre: Database.shared.continent);
            continentsPlanete.text = "\(String(describing: planetContinents!))"
            
            let planetTemperature = Database.shared.getPlanetParameter(id: planetID, parametre: Database.shared.temperature);
            temperaturePlanete.text = "\(String(describing: planetTemperature!)) °C"
            
            let planetHumidite = Database.shared.getPlanetParameter(id: planetID, parametre: Database.shared.humidite);
            humiditePlanete.text = "\(String(describing: planetHumidite!))%"
            
            let planetPression = Database.shared.getPlanetParameter(id: planetID, parametre: Database.shared.pression);
            pressionPlanete.text = "\(String(describing: planetPression!)) atm"
            
            let planetAtmosphere = Database.shared.getPlanetAthmosphere(id: planetID);
            atmospherePlanete.text = ""
            var countAtmosphere = planetAtmosphere.count
            for element in planetAtmosphere {
                atmospherePlanete.text! += element
                if countAtmosphere > 6 {
                    atmospherePlanete.font = UIFont(name: "Marker Felt Wide", size: 15.0)
                }
                if countAtmosphere != 1 {
                    atmospherePlanete.text! += " - "
                    countAtmosphere -= 1
                }
            }
            
            let planetRessources = Database.shared.getPlanetRessource(id: planetID);
            ressourcesPlanete.text = ""
            var countRessources = planetRessources.count
            for ressource in planetRessources {
                ressourcesPlanete.text! += ressource
                if countRessources > 6 {
                    ressourcesPlanete.font = UIFont(name: "Marker Felt Wide", size: 15.0)
                }
                if countRessources != 1 {
                    ressourcesPlanete.text! += " - "
                    countRessources -= 1
                }
            }
        }
    }
}
    

class PlanetShow{
    
    static let shared = PlanetShow()
    
    var planetToShowId = 1
    
    init(){
        
    }
    
}
