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
    
    var imageToSpawn : String = "nil"
    
    var moveImages : [UIImageView] = []
    var objectTouch = -1
    let ImagesList = ImageSpawns.shared
    
    var dataBiodiv = [1: "1", 2: "1", 3: "1", 4: "1", 5: "1", 6: "1", 7: "1", 8: "1", 9: "1"]

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
            
            if(imageToSpawn != "nil"){
                ImagesList.addLocation(name: imageToSpawn, x: 410/2, y: 939/2)
            }
            
            for img in ImagesList.images{
                let imageView = UIImageView(frame: CGRect(x: img.x - 50, y: img.y - 50, width: 100, height: 100))
                imageView.image = UIImage(named: img.name)
                
                self.view.addSubview(imageView)
                
                moveImages.append(imageView)
            }
        }
        
        if ButtonsType != nil{
            let types = Database.shared.getBiodivType(type: planetType!)
            var i = 0
            for button in ButtonsType{
                if types.count <= i || types.count == 0{
                    button.isHidden = true
                }else{
                    button.isHidden = false
                    button.titleLabel?.text = types[i]
                    dataBiodiv[button.tag] = types[i]
                    i += 1
                }
            }
        }
    }
    
    
    @IBAction func SelectType(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view2 = storyboard.instantiateViewController(withIdentifier: "listbiodiv") as! BiodiversiteView
        view2.name = dataBiodiv[sender.tag]!
        
        view2.modalPresentationStyle = .fullScreen
        present(view2, animated: false, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let t = touches.randomElement()!
        let p = t.location(in: view)
        var i = 0
        for d in moveImages {
            if d.frame.contains(p){
                objectTouch = i
            }
            i+=1
        }
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(objectTouch >= 0){
            let t = touches.randomElement()!
            let p = t.location(in: view)
            if(!ImagesList.images.isEmpty){
                moveImages[objectTouch].center = p
                ImagesList.images[objectTouch].x = p.x
                ImagesList.images[objectTouch].y = p.y
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
       objectTouch = -1
   }
}
