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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PlanetImage.image = UIImage(named: Database.shared.getPlanetType(id: Database.shared.getLastId()))
    }
}
