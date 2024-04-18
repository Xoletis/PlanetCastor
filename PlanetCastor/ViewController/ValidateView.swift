//
//  ValidateView.swift
//  PlanetCastor
//
//  Created by Ivan Rocque on 18/04/2024.
//

import Foundation
import UIKit

class ValidateView: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func CreatePlanet(_ sender: Any) {
        for bio in ImageSpawns.shared.images{
            Database.shared.addSpaciesOnPlanet(planet: Database.shared.getLastId(), img: bio.name, x: Int(bio.x), y: Int(bio.y))
        }
        
        for img in ImageSpawns.shared.images{
            print(img.name, " ,", img.x, ", ", img.y)
        }
        
        
        ImageSpawns.shared.images = []
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view2 = storyboard.instantiateViewController(withIdentifier: "MainMenu") as! ViewController
        
        view2.modalPresentationStyle = .fullScreen
        present(view2, animated: false, completion: nil)
    }
    
    
}

