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
    
    
    @IBOutlet var ButtonsType: [UIButton]!
    
    var planetID = 0
    
    var planetType : String?
    
    override func viewDidLoad() {
            super.viewDidLoad()
        
        planetID = Database.shared.getLastId()

        planetType = Database.shared.getPlanetParameter(id: planetID, parametre: Database.shared.type)?.lowercased();
        if PlanetImage != nil{
            PlanetImage.image = UIImage(named: planetType!)
            plusButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.40).cgColor
            plusButton.layer.shadowOpacity = 0.9
            plusButton.layer.shadowOffset = CGSize(width: 1.5, height: 4.0)
            plusButton.layer.shadowRadius = 2
            plusButton.layer.cornerRadius = 4.0
        }
        
        if ButtonsType != nil{
            let types = Database.shared.getBiodivType(type: planetType!)
            var i = 0
            for button in ButtonsType{
                if types.count < i || types.count == 0{
                    button.isHidden = true
                }else{
                    button.isHidden = false
                    button.titleLabel?.text = types[i]
                    i += 1
                }
            }
        }
    }
    
    
    @IBAction func SelectType(_ sender: UIButton) {
            
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view2 = storyboard.instantiateViewController(withIdentifier: "listbiodiv") as! BiodiversiteView
        view2.name = (sender.titleLabel?.text)!
        view2.modalPresentationStyle = .overCurrentContext
        present(view2, animated: false, completion: nil)
    }
    
}
