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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func ClickOnTerrestreButton(_ sender: UIButton) {
        for button in ButtonsTypePlanet{
            button.configuration?.baseBackgroundColor = UIColor.white;
        }
        sender.configuration?.baseBackgroundColor = UIColor(red: 217/255, green: 169/255, blue: 255/255, alpha: 1);
    }
}
