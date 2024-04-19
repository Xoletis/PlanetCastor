//
//  GalerieId.swift
//  PlanetCastor
//
//  Created by Ivan Rocque on 16/04/2024.
//

import Foundation
import UIKit

class GalerieId: UIViewController {
    @IBOutlet var idParameter: [UILabel]!
    
    @IBOutlet weak var nomEtoile: UILabel!
    @IBOutlet weak var imgEtoile: UIImageView!
    @IBOutlet weak var nombreLunes: UILabel!
    @IBOutlet weak var chaleur: UILabel!
    @IBOutlet weak var descriptionPlanete: UILabel!
    
    var planetID = 1
    var chaleurs = ["soleil1": "50000K",
                            "soleil2": "600000K",
                            "soleil3": "1 million de K",
                            "soleil4": "2 millions de K",
                            "soleil5": "2,5 millions de K",
                            "soleil6": "6 millions de K"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        planetID = PlanetShow.shared.planetToShowId
        let data = Database.shared

        
        for parameter in idParameter {
            parameter.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
            parameter.layer.borderWidth = 1.0
            parameter.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.40).cgColor
            parameter.layer.shadowOpacity = 0.9
            parameter.layer.shadowOffset = CGSize(width: 1.5, height: 4.0)
            parameter.layer.shadowRadius = 2
            parameter.layer.cornerRadius = 16.0
            parameter.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        }
        
        let nbLunes = Database.shared.getPlanetParameter(id: planetID, parametre: Database.shared.moon);
        nomEtoile.text = "\(String(describing: nbLunes!))"
        
        let etoileName = Database.shared.getPlanetParameter(id: planetID, parametre: Database.shared.starname);
        nomEtoile.text = "\(String(describing: etoileName!).uppercased())"
        
        let description = Database.shared.getPlanetParameter(id: planetID, parametre: Database.shared.planetdesc);
        descriptionPlanete.text = "\(String(describing: description!).uppercased())"
        
        let imgNumber = (data.getPlanetParameter(id: planetID, parametre: data.startype))
        imgEtoile.image = UIImage(named: "soleil\(imgNumber!)")
        
        chaleur.text = chaleurs["soleil\(imgNumber!)"]
    }
    
}
