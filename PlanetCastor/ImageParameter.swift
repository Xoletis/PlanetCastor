//
//  ImageParameter.swift
//  PlanetCastor
//
//  Created by Ivan Rocque on 10/04/2024.
//

import Foundation
import UIKit

class ImageParameter: UIViewController {
   
    @IBOutlet weak var PlanetImage: UIImageView!
    @IBOutlet weak var plusButton: UIButton!
    
    var planetID = 0
    
    override func viewDidLoad() {
            super.viewDidLoad()
        
        planetID = Database.shared.getLastId()

        let planetType = Database.shared.getPlanetParameter(id: planetID, parametre: Database.shared.type).lowercased();
        PlanetImage.image = UIImage(named: planetType)
        
        print(Database.shared.getPlanetRessource(id: planetID))


      
        plusButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.40).cgColor
        plusButton.layer.shadowOpacity = 0.9
        plusButton.layer.shadowOffset = CGSize(width: 1.5, height: 4.0)
        plusButton.layer.shadowRadius = 2
        plusButton.layer.cornerRadius = 4.0
    }
}
