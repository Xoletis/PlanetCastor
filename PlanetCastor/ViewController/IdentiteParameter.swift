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
    
    @IBOutlet weak var PlanetNom: UITextField!
    @IBOutlet weak var PlanetDesc: UITextField!
    @IBOutlet weak var StarName: UITextField!
    @IBOutlet var buttonsShadow: [UIButton]!
    
    @IBOutlet var EtoileColorButton: [UIButton]!
    var data = Database.shared
    var id : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        id = data.getLastId()
        
        for button in buttonsShadow {
            button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.40).cgColor
            button.layer.shadowOpacity = 0.9
            button.layer.shadowOffset = CGSize(width: 1.5, height: 4.0)
            button.layer.shadowRadius = 2
            button.layer.cornerRadius = 4.0
        }
        
        PlanetNom.placeholder = data.getPlanetParameter(id: id, parametre: data.planetname)
        
        PlanetDesc.placeholder = data.getPlanetParameter(id: id, parametre: data.planetdesc)
        
        nombreLunes.text = String(Int(data.getPlanetParameter(id: id, parametre: data.moon)!))
        
        StarName.placeholder = data.getPlanetParameter(id: id, parametre: data.starname)
        
        for btn in EtoileColorButton{
            btn.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 0)
            if(btn.tag == data.getPlanetParameter(id: id, parametre: data.startype)){
                btn.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
                btn.layer.borderWidth = 4
                btn.layer.cornerRadius = 18
            }
        }
    }
    
    @IBAction func ClickOnPlusLune(_ sender: Any) {
        var nombreToUpdate = Int(nombreLunes.text!)!
        nombreToUpdate += 1
        nombreLunes.text = String(nombreToUpdate)
        data.setPlanetParameter(id: data.getLastId(), parametre: data.moon, value: nombreToUpdate)
    }
    
    @IBAction func ClickOnMinusLune(_ sender: Any) {
        var nombreToUpdate = Int(nombreLunes.text!)!
        if nombreToUpdate > 0 {
            nombreToUpdate -= 1
            nombreLunes.text = String(nombreToUpdate)
            data.setPlanetParameter(id: data.getLastId(), parametre: data.moon, value: nombreToUpdate)
        }
    }
    
    @IBAction func ChangeName(_ sender: UITextField) {
        data.setPlanetParameter(id: id, parametre: data.planetname, value: (sender.text)!)
    }
    
    
    @IBAction func ChangeDesc(_ sender: UITextField) {
        data.setPlanetParameter(id: id, parametre: data.planetdesc, value: (sender.text)!)
    }
    
    
    @IBAction func ChangeStarName(_ sender: UITextField) {
        data.setPlanetParameter(id: id, parametre: data.starname, value: (sender.text)!)
    }
    
    
    @IBAction func ChoosePlanet(_ sender: UIButton) {
        for btn in EtoileColorButton{
            btn.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 0)
        }
        sender.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        sender.layer.borderWidth = 4
        sender.layer.cornerRadius = 18
        
        data.setPlanetParameter(id: id, parametre: data.startype, value: sender.tag)
    }
}
      
