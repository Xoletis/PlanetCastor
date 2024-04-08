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
    
    @IBOutlet weak var NextPageType: UIBarButtonItem!
    
    var planetType : String!
    var planetId : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for button in ButtonsTypePlanet {
            button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.40).cgColor
            button.layer.shadowOpacity = 0.9
            button.layer.shadowOffset = CGSize(width: 1.5, height: 4.0)
            button.layer.shadowRadius = 2
            button.layer.cornerRadius = 4.0
        }
        
        planetType = "nil"
        
        if planetType == "nil"{
            NextPageType.isEnabled = false
        }
        
        planetId = Database.shared.createPlanet()
        
    }
    
    
    @IBAction func ClickOnTerrestreButton(_ sender: UIButton) {
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
}
