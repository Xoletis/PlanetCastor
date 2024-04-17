//
//  IdentiteParameter.swift
//  PlanetCastor
//
//  Created by Anna Sarbiewski on 15/04/2024.
//

import Foundation
import UIKit

class IdentiteParameter: UIViewController {
    
    @IBOutlet weak var nombreLunes: UILabel!
    
    @IBOutlet var buttonsShadow: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for button in buttonsShadow {
            button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.40).cgColor
            button.layer.shadowOpacity = 0.9
            button.layer.shadowOffset = CGSize(width: 1.5, height: 4.0)
            button.layer.shadowRadius = 2
            button.layer.cornerRadius = 4.0
        }
        
    }
    
    @IBAction func ClickOnPlusLune(_ sender: Any) {
        var nombreToUpdate = Int(nombreLunes.text!)!
        nombreToUpdate += 1
        nombreLunes.text = String(nombreToUpdate)
    }
    
    @IBAction func ClickOnMinusLune(_ sender: Any) {
        var nombreToUpdate = Int(nombreLunes.text!)!
        if nombreToUpdate > 0 {
            nombreToUpdate -= 1
            nombreLunes.text = String(nombreToUpdate)
        }
    }
}
      
