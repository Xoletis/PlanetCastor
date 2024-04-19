//
//  ImageResultatParameter.swift
//  PlanetCastor
//
//  Created by Anna Sarbiewski on 10/04/2024.
//

import Foundation
import UIKit

class ImageResultatParameter: UIViewController {
       
    @IBOutlet weak var imageFond: UIImageView!
    
    let data = Database.shared
    let id = PlanetShow.shared.planetToShowId
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bundlePath = Bundle.main.path(forResource: "images", ofType: "bundle")!
        let bundle = Bundle(path: bundlePath)
        
        print(bundle)
        
        imageFond.image = UIImage(named: data.getPlanetParameter(id: id, parametre: data.type)!)
        
        for loc in data.getBiodivOnPlanet(id: id){
            let imageView = UIImageView(frame: CGRect(x: loc.x - 50, y: loc.y - 50, width: 100, height: 100))
            let parties = loc.name.split(separator: "_")
            let image = UIImage(named: "\(parties[0])/\(loc.name)", in: bundle, compatibleWith: nil)
            imageView.image = image
            
            self.view.addSubview(imageView)
        }
    }
    
}
        
