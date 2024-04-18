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
    
    @IBOutlet weak var imagePlanete: UIImageView!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var pressionLabel: UILabel!
    @IBOutlet weak var humiditeLabel: UILabel!
    
    @IBOutlet weak var infosDiametreButton: UIButton!
    
    @IBOutlet weak var DiametreParameter: UITextField!
    @IBOutlet weak var ContinentPatameter: UITextField!
    @IBOutlet weak var TemperaturePatameter: UISlider!
    @IBOutlet weak var HumiditePatameter: UISlider!
    @IBOutlet weak var PressionPatameter: UISlider!
    
    let data = Database.shared
    
    var receivedData: Bool?
    
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
            
            ImageSpawns.shared.images = []
            data.createTable()
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
            
            planetId = data.createPlanet()
        }else{
            planetId = data.getLastId()
        }
        
        if DiametreParameter != nil{
            let diametre = data.getPlanetParameter(id: planetId, parametre: data.diametre)
            let continent = data.getPlanetParameter(id: planetId, parametre: data.continent)
            let temperature = data.getPlanetParameter(id: planetId, parametre: data.temperature)
            let humidite = data.getPlanetParameter(id: planetId, parametre: data.humidite)
            let pression = data.getPlanetParameter(id: planetId, parametre: data.pression)
            
            DiametreParameter.placeholder = "\(diametre!)"
            ContinentPatameter.placeholder = "\(continent!)"
            TemperaturePatameter.value = Float(temperature!)
            HumiditePatameter.value = Float(humidite!)
            PressionPatameter.value = Float(pression!)
            
            temperatureLabel.text = "\(temperature!)"
            humiditeLabel.text = "\(humidite!)"
            pressionLabel.text = "\(pression!)"
            
            let atmospheres = data.getPlanetAthmosphere(id : planetId)
            
            for atm in ButtonsAtmosphere{
                let name = atm.titleLabel?.text
                if atmospheres.contains(name!){
                    atmospheresChoisies.append(name)
                    atm.configuration?.baseForegroundColor = UIColor(red: 217/255, green: 169/255, blue: 255/255, alpha: 1);
                    atm.layer.borderColor = CGColor(red: 217/255, green: 169/255, blue: 255/255, alpha: 1)
                    atm.layer.borderWidth = 3
                    atm.layer.cornerCurve = .continuous
                }
            }
            
            let ressources = data.getPlanetRessource(id : planetId)
            
            for res in ButtonsRessources{
                let name = res.titleLabel?.text
                if ressources.contains(name!){
                    ressourcesChoisies.append(name)
                    res.configuration?.baseForegroundColor = UIColor(red: 217/255, green: 169/255, blue: 255/255, alpha: 1);
                    res.layer.borderColor = CGColor(red: 217/255, green: 169/255, blue: 255/255, alpha: 1)
                    res.layer.borderWidth = 3
                    res.layer.cornerCurve = .continuous
                }
            }
        }
        
        
        
    }
    
    @IBAction func ChooseTemperature(_ sender: UISlider) {
        temperatureLabel.text! = Int(sender.value).description + " °C"
        data.setPlanetParameter(id: self.planetId, parametre: data.temperature, value: Int(sender.value))
    }
    
    @IBAction func ChooseHumidite(_ sender: UISlider) {
        humiditeLabel.text! = Int(sender.value).description + " %"
        data.setPlanetParameter(id: self.planetId, parametre: data.humidite, value: Int(sender.value))
    }
    
    @IBAction func ChoosePression(_ sender: UISlider) {
        pressionLabel.text! = Int(sender.value).description + " atm"
        data.setPlanetParameter(id: self.planetId, parametre: data.pression, value: Int(sender.value))
    }
    
    @IBAction func ClickAtmosphereButton(_ sender: UIButton) {
        
        let tag = sender.tag
        
        if atmospheresChoisies.contains(sender.titleLabel?.text) == false {
            atmospheresChoisies.append(sender.titleLabel?.text)
            sender.configuration?.baseForegroundColor = UIColor(red: 217/255, green: 169/255, blue: 255/255, alpha: 1);
            sender.layer.borderColor = CGColor(red: 217/255, green: 169/255, blue: 255/255, alpha: 1)
            sender.layer.borderWidth = 3
            sender.layer.cornerCurve = .continuous
            data.addAtmosphere(atmosphereID: tag, planetID: self.planetId)
        } else {
            let indexElement = atmospheresChoisies.firstIndex(of: sender.titleLabel?.text)
            atmospheresChoisies.remove(at: indexElement!)
            sender.configuration?.baseForegroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1);
            sender.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0)
            sender.layer.borderWidth = 1
            data.removeAtmosphere(atmosphereID: tag, planetID: self.planetId)
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
            data.addRessource(ressourceID: tag, planetID: self.planetId)
        } else {
            let indexElement = ressourcesChoisies.firstIndex(of: sender.titleLabel?.text)
            ressourcesChoisies.remove(at: indexElement!)
            sender.configuration?.baseForegroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1);
            sender.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0)
            sender.layer.borderWidth = 1
            data.removeRessource(ressourceID: tag, planetID: self.planetId)
        }
    }
    
    @IBAction func ClickOnTypePlanete(_ sender: UIButton) {
        for button in ButtonsTypePlanet{
            button.configuration?.baseBackgroundColor = UIColor.white;
        }
        sender.configuration?.baseBackgroundColor = UIColor(red: 217/255, green: 169/255, blue: 255/255, alpha: 1);
        
        planetType = sender.configuration?.title?.lowercased();
        imagePlanete.image = UIImage(named: "Planete\((sender.configuration?.title)!.prefix(1) + ((sender.configuration?.title)!.suffix(planetType.count - 1)).lowercased())")
        
        if planetType == "nil"{
            NextPageType.isEnabled = false
        }else{
            NextPageType.isEnabled = true
        }
        
        data.setPlanetParameter(id: planetId, parametre: data.type, value: planetType!)
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
            data.setPlanetParameter(id: self.planetId, parametre: data.diametre, value: diametre)
        }
    }
    
    @IBAction func ContinentChange(_ sender: UITextField) {
        let text = sender.text!
        if let continent = Int(text){
            data.setPlanetParameter(id: self.planetId, parametre: data.continent, value: continent)
        }
    }
    
    @IBAction func BackToMainMenu(_ sender: UIButton) {
        
        data.removeLastPlanet()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view2 = storyboard.instantiateViewController(withIdentifier: "MainMenu") as! ViewController
        
        view2.modalPresentationStyle = .fullScreen
        present(view2, animated: false, completion: nil)
    }
    
}
