//
//  ViewController.swift
//  PlanetCastor
//
//  Created by Ivan Rocque on 04/04/2024.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet var buttons: [UIButton]!
    
    @IBOutlet weak var ImagePrincipal: UIImageView!
    
    let imagesList : [String] = ["Teth", "PlaneteVolcanique", "PlaneteUrbaine", "PlaneteTropicale", "PlaneteTerrestre", "PlaneteNuageuse", "PlaneteMarecageuse", "PlaneteGlaciaire", "PlaneteGazeuse", "PlaneteAride", "PlaneteAquatique", "Kashyyk", "Fondor"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Database.shared.createTable()
        
        for button in buttons {
            button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.40).cgColor
            button.layer.shadowOpacity = 0.9
            button.layer.shadowOffset = CGSize(width: 1.5, height: 4.0)
            button.layer.shadowRadius = 2
            button.layer.cornerRadius = 4.0
        }
        
        ImagePrincipal.image = UIImage(named: imagesList.randomElement()!)
    }
}

