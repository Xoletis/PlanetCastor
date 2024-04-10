//
//  PlanetPatameter.swift
//  PlanetCastor
//
//  Created by Ivan Rocque on 05/04/2024.
//

import Foundation
import UIKit

class PlaneteParameter: UIViewController {
      
    @IBOutlet var ButtonsTypePlanet: [UIButton]!
    @IBOutlet var ButtonsAtmosphere: [UIButton]!
    @IBOutlet var ButtonsRessources: [UIButton]!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var pressionLabel: UILabel!
    @IBOutlet weak var humiditeLabel: UILabel!
    
    @IBOutlet weak var infosDiametreButton: UIButton!
    
    
    
    var atmospheresChoisies: [String?] = []
    var ressourcesChoisies: [String?] = []
    
    var informationMessages = [0: "Cette variable correspond au diamètre de votre planète. \nPour comparaison, celui de la                            terre est de 12 742km.",
                            1: "Cette variable correspond au nombre de continents de votre planète. \nPour comparaison, sur terre il y a 7 contients.",
                            2: "Cette variable correspond à la temperature moyennes sur votre planete. \nPour comparaison, sur terre il fait 15°C en moyenne.",
                            3: "Cette variable correspond au pourcentage moyen d’humidité sur votre planete. \nPour comparaison, sur terre Il y a 30% d’humidité en moyenne.",
                            4: "Cette variable correspond à la pression atmospherique de votre planete. \nPour comparaison, sur terre la pression atmospherique est de 1 atm.",
                            5: "Selectionez les différents gaz qui composent votre atmosphère. \nSur terre nous avons du dihydrogène, de l’hélium, du diazote, du dioxygène, du dioxyde de carbone et du méthane."]
  
    
    @IBOutlet weak var NextPageType: UIButton!
    
    var planetType : String!
    var planetId : Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        if ButtonsTypePlanet != nil {
            for button in ButtonsTypePlanet {
                button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.40).cgColor
                button.layer.shadowOpacity = 0.9
                button.layer.shadowOffset = CGSize(width: 1.5, height: 4.0)
                button.layer.shadowRadius = 2
                button.layer.cornerRadius = 4.0
            }
        }
        if ButtonsAtmosphere != nil {
            for button in ButtonsAtmosphere {
                button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.40).cgColor
                button.layer.shadowOpacity = 0.9
                button.layer.shadowOffset = CGSize(width: 1.5, height: 4.0)
                button.layer.shadowRadius = 2
                button.layer.cornerRadius = 16
            }
        }
        if ButtonsRessources != nil {
            for button in ButtonsRessources {
                button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.40).cgColor
                button.layer.shadowOpacity = 0.9
                button.layer.shadowOffset = CGSize(width: 1.5, height: 4.0)
                button.layer.shadowRadius = 2
                button.layer.cornerRadius = 16
            }
        }
        
        if ButtonsTypePlanet != nil{
            planetType = "nil"
            
            if planetType == "nil" {
                if NextPageType != nil{
                    NextPageType.isEnabled = false
                }
            }
            
            planetId = Database.shared.createPlanet()
        }else{
            planetId = Database.shared.getLastId()
        }
    }
    
    @IBAction func ChooseTemperature(_ sender: UISlider) {
        temperatureLabel.text! = Int(sender.value).description + " °C"
        Database.shared.setTemperature(temperature: Int(sender.value), id: self.planetId)
    }
    
    @IBAction func ChooseHumidite(_ sender: UISlider) {
        humiditeLabel.text! = Int(sender.value).description + " %"
        Database.shared.setHumidite(humidite: Int(sender.value), id: self.planetId)
    }
    
    @IBAction func ChoosePression(_ sender: UISlider) {
        pressionLabel.text! = Int(sender.value).description + " atm"
        Database.shared.setPression(pression: Int(sender.value), id: self.planetId)
    }
    
    @IBAction func ClickAtmosphereButton(_ sender: UIButton) {
        
        let tag = sender.tag
        
        if atmospheresChoisies.contains(sender.titleLabel?.text) == false {
            atmospheresChoisies.append(sender.titleLabel?.text)
            sender.configuration?.baseForegroundColor = UIColor(red: 217/255, green: 169/255, blue: 255/255, alpha: 1);
            sender.layer.borderColor = CGColor(red: 217/255, green: 169/255, blue: 255/255, alpha: 1)
            sender.layer.borderWidth = 3
            sender.layer.cornerCurve = .continuous
            Database.shared.addAtmosphere(atmosphereID: tag, planetID: self.planetId)
        } else {
            let indexElement = atmospheresChoisies.firstIndex(of: sender.titleLabel?.text)
            atmospheresChoisies.remove(at: indexElement!)
            sender.configuration?.baseForegroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1);
            sender.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0)
            sender.layer.borderWidth = 1
            Database.shared.removeAtmosphere(atmosphereID: tag, planetID: self.planetId)
        }
    }
    
    @IBAction func ClickRessourcesButton(_ sender: UIButton) {
        let tag = sender.tag
        
        if ressourcesChoisies.contains(sender.titleLabel?.text) == false {
            ressourcesChoisies.append(sender.titleLabel?.text)
            sender.configuration?.baseForegroundColor = UIColor(red: 217/255, green: 169/255, blue: 255/255, alpha: 1);
            sender.layer.borderColor = CGColor(red: 217/255, green: 169/255, blue: 255/255, alpha: 1)
            sender.layer.borderWidth = 3
            sender.layer.cornerCurve = .continuous
            Database.shared.addRessource(ressourceID: tag, planetID: self.planetId)
        } else {
            let indexElement = ressourcesChoisies.firstIndex(of: sender.titleLabel?.text)
            ressourcesChoisies.remove(at: indexElement!)
            sender.configuration?.baseForegroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1);
            sender.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0)
            sender.layer.borderWidth = 1
            Database.shared.removeRessource(ressourceID: tag, planetID: self.planetId)
        }
    }
    
    @IBAction func ClickOnTypePlanete(_ sender: UIButton) {
        for button in ButtonsTypePlanet{
            button.configuration?.baseBackgroundColor = UIColor.white;
        }
        sender.configuration?.baseBackgroundColor = UIColor(red: 217/255, green: 169/255, blue: 255/255, alpha: 1);
        
        planetType = sender.configuration?.title;
        if planetType == "nil"{
            NextPageType.isEnabled = false
        }else{
            NextPageType.isEnabled = true
        }
        
        Database.shared.setType(type: planetType, id: planetId)
    }
    
    @IBAction func ClickOnInfo(_ sender: UIButton) {
        let text = informationMessages[sender.tag]
        let alert = UIAlertController(title: "", message: text, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func DiametreChange(_ sender: UITextField, forEvent event: UIEvent) {
        let text = sender.text!
        if let diametre = Int(text) {
            Database.shared.setDiametre(diametre: diametre, id: planetId)
        }
    }
    
    @IBAction func ContinentChange(_ sender: UITextField) {
        let text = sender.text!
        if let continent = Int(text){
            Database.shared.setContinent(continent: continent, id: planetId)
        }
    }
    
    
}
