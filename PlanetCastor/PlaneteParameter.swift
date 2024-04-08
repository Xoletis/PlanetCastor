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
                button.layer.cornerRadius = 4.0
            }
        }
    }
    
    
    @IBAction func ClickAtmosphereButton(_ sender: UIButton) {
        if sender.layer.borderColor == CGColor(red: 217/255, green: 169/255, blue: 255/255, alpha: 1){
            sender.configuration?.baseForegroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1);
            sender.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0)
            sender.layer.borderWidth = 1
        } else {
            sender.configuration?.baseForegroundColor = UIColor(red: 217/255, green: 169/255, blue: 255/255, alpha: 1);
            sender.layer.borderColor = CGColor(red: 217/255, green: 169/255, blue: 255/255, alpha: 1)
            sender.layer.borderWidth = 3
            sender.layer.cornerCurve = .continuous
        }
    }
    
    @IBAction func ClickOnTerrestreButton(_ sender: UIButton) {
        for button in ButtonsTypePlanet{
            button.configuration?.baseBackgroundColor = UIColor.white;
        }
        sender.configuration?.baseBackgroundColor = UIColor(red: 217/255, green: 169/255, blue: 255/255, alpha: 1);
    }
}
