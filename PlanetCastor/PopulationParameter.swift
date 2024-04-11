//
//  PopulationParameter.swift
//  PlanetCastor
//
//  Created by Anna Sarbiewski on 11/04/2024.
//

import Foundation
import UIKit

class PopulationParameter: UIViewController {
       
    @IBOutlet weak var popCouleur: UIColorWell!
    @IBOutlet weak var popCouleurPresentation: UIButton!
    let dataSource = ["Humanoïde", "Avianoïde", "Aquaréens", "Arboriens", "Kiwi", "Watermelon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popCouleur.addTarget(self, action: #selector(colorChanged), for: .valueChanged)
        popCouleurPresentation.layer.backgroundColor = popCouleur.selectedColor?.cgColor
        popCouleurPresentation.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.40).cgColor
        popCouleurPresentation.layer.shadowOpacity = 0.9
        popCouleurPresentation.layer.shadowOffset = CGSize(width: 1.5, height: 4.0)
        popCouleurPresentation.layer.shadowRadius = 2
        popCouleurPresentation.layer.cornerRadius = 4.0
        popCouleurPresentation.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        popCouleurPresentation.layer.borderWidth = 1.0
        
        
        let button = UIButton(primaryAction: nil)

           let actionClosure = { (action: UIAction) in
               print(action.title)
           }

           var menuChildren: [UIMenuElement] = []
           for fruit in dataSource {
               menuChildren.append(UIAction(title: fruit, handler: actionClosure))
           }
           
           button.menu = UIMenu(options: .displayInline, children: menuChildren)
           
           button.showsMenuAsPrimaryAction = true
           button.changesSelectionAsPrimaryAction = true
           
           button.frame = CGRect(x: 150, y: 200, width: 100, height: 40)
           self.view.addSubview(button)
    }
    
    @objc private func colorChanged() {
        popCouleurPresentation.layer.backgroundColor = popCouleur.selectedColor?.cgColor
    }
    
}
        
