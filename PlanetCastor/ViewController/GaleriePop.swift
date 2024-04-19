//
//  GalerieId.swift
//  PlanetCastor
//
//  Created by Ivan Rocque on 16/04/2024.
//

import Foundation
import UIKit

class GaleriePop: UIViewController {
    @IBOutlet var popParameter: [UILabel]!
    
    @IBOutlet weak var nom: UILabel!
    @IBOutlet weak var couleur: UILabel!
    @IBOutlet weak var regimePolitique: UILabel!
    @IBOutlet weak var langue: UILabel!
    @IBOutlet weak var aspect: UILabel!
    @IBOutlet weak var aspectExplications: UILabel!
    @IBOutlet weak var avanceeTechno: UILabel!
    @IBOutlet weak var caractere: UILabel!
    
    var planetID = 1
    
    var dataSourceAspect = ["Humanoïde": "Une population qui ressemble à celle de la planète Terre.",
                            "Avianoïde": "Une population ailée, évoquant les oiseaux ou les anges.",
                            "Aquaréen": "Des êtres aquatiques rappelant les créatures marines.",
                            "Arborien": "Des êtres vivant dans les arbres, avec une physiologie adaptée à la vie arboricole.",
                            "Crystallith": "Des êtres faits de cristaux, avec une apparence brillante et translucide.",
                            "Lithoïde": "Des créatures rocheuses, ressemblant à des éléments minéraux ou des pierres précieuses.",
                            "Nébuloïde": "Des entités éthérées, évoquant les nuages ou les formations gazeuses.",
                            "Biofluorescent": "Des êtres luminescents, inspirés par la bioluminescence des créatures marines.",
                            "Technoïde": "Des populations intégrant des éléments technologiques dans leur physiologie, semblables à des cyborgs organiques.",
                            "Electroïde": "Des êtres énergétiques, capables de manipuler l'électricité ou de se fondre dans des formes d'énergie.",
                            "Sylphide": "Des créatures aériennes, évoquant les esprits de l'air et les vents.",
                            "Xénoïde": "Des populations extraterrestres, avec des caractéristiques physiques étranges et non familières.",
                            "Pyroïde": "Des êtres associés au feu et à la chaleur, ayant une apparence ardente et flamboyante.",
                            "Gelidien": "Des populations vivant dans des environnements glacés, avec une physiologie adaptée au froid extrême.",
                            "Thérian": "Des populations dotées de caractéristiques animales, combinant des traits humains et bestiaux.",
                            "Pyroclaste": "Des populations associées aux volcans et aux éruptions, possédant une physiologie résistante à la chaleur et aux éléments volcaniques.",
                            "Aéroïde": "Des populations vivant dans l'atmosphère, avec une physiologie adaptée à la vie en haute altitude.",
                            "Métaïde": "Des êtres métamorphes, capables de changer de forme et d'adopter différentes apparences selon les circonstances."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        planetID = PlanetShow.shared.planetToShowId
                
        for parameter in popParameter {
            parameter.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
            parameter.layer.borderWidth = 1.0
            parameter.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.40).cgColor
            parameter.layer.shadowOpacity = 0.9
            parameter.layer.shadowOffset = CGSize(width: 1.5, height: 4.0)
            parameter.layer.shadowRadius = 2
            parameter.layer.cornerRadius = 16.0
            parameter.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        }
        
        let populationAspect = Database.shared.getPlanetParameter(id: planetID, parametre: Database.shared.aspect)?.uppercased();
        aspect.text = populationAspect
        
        aspectExplications.text = dataSourceAspect[(aspect.text!.prefix(1)) + (aspect.text!.suffix(aspect.text!.count - 1)).lowercased()]!
        
        let popNom = Database.shared.getPlanetParameter(id: planetID, parametre: Database.shared.habitantName);
        nom.text = "\(String(describing: popNom!))"
        
        let popRegimePolitique = Database.shared.getPlanetParameter(id: planetID, parametre: Database.shared.politique);
        regimePolitique.text = "\(String(describing: popRegimePolitique!))"
        
        let popLangue = Database.shared.getPlanetParameter(id: planetID, parametre: Database.shared.langue);
        langue.text = "\(String(describing: popLangue!))"
        
        let popAvanceeTechnologique = Database.shared.getPlanetParameter(id: planetID, parametre: Database.shared.tech);
        avanceeTechno.text = "\(String(describing: popAvanceeTechnologique!))"
        
        let PopcouleurB = Database.shared.getPlanetParameter(id: planetID, parametre: Database.shared.color_b);
        let PopcouleurR = Database.shared.getPlanetParameter(id: planetID, parametre: Database.shared.color_r);
        let PopcouleurG = Database.shared.getPlanetParameter(id: planetID, parametre: Database.shared.color_g);
        couleur.backgroundColor = UIColor(red: CGFloat(PopcouleurR!), green: CGFloat(PopcouleurG!), blue: CGFloat(PopcouleurB!), alpha: 1)
        
        let popCaractere = Database.shared.getPlanetCar(id: planetID);
        caractere.text = ""
        var countCaractere = popCaractere.count
        for element in popCaractere {
            caractere.text! += element
            if countCaractere > 6 {
                caractere.font = UIFont(name: "Marker Felt Wide", size: 13.0)
            }
            if countCaractere != 1 {
                caractere.text! += " - "
                countCaractere -= 1
            }
        }
    }
}
