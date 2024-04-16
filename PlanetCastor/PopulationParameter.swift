//
//  PopulationParameter.swift
//  PlanetCastor
//
//  Created by Anna Sarbiewski on 11/04/2024.
//

import Foundation
import UIKit

class PopulationParameter: UIViewController {
    
    @IBOutlet weak var Language: UITextField!
    @IBOutlet weak var SpaciesName: UITextField!
    @IBOutlet var shadowButtons: [UIButton]!
    @IBOutlet weak var popCouleur: UIColorWell!
    @IBOutlet weak var popCouleurPresentation: UIButton!
    @IBOutlet weak var aspectExplication: UILabel!
    @IBOutlet weak var regimeExplication: UILabel!
    let aspectButton = UIButton(primaryAction: nil)
    let regimeButton = UIButton(primaryAction: nil)
    let data = Database.shared
    @IBOutlet var CaractersButton: [UIButton]!
    
    var caractereChoisies: [String?] = []
    
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
    
    var dataSourceRegime = ["Démocratie": "Un système politique dans lequel le pouvoir est exercé par le        peuple, directement ou par l'intermédiaire de représentants élus.",
                            "Monarchie": "Un système politique dans lequel le pouvoir est détenu par un monarque, tel qu'un roi ou une reine, souvent héréditaire.",
                            "République": "Un système politique dans lequel le chef de l'État est élu par le peuple ou par un corps électoral, plutôt que d'être hérité.",
                            "Dictature": "Un système politique dans lequel le pouvoir est concentré entre les mains d'un individu ou d'un petit groupe, généralement sans consultation du peuple et souvent par la force.",
                            "Théocratie": "Un système politique dans lequel le pouvoir est exercé par des dirigeants religieux ou en conformité avec les lois religieuses.",
                            "Oligarchie": "Un système politique dans lequel le pouvoir est exercé par un petit groupe de personnes ayant des intérêts communs ou des privilèges partagés.",
                            "Ploutocratie": "Un système politique dans lequel le pouvoir est exercé par les riches ou par ceux qui ont un accès considérable à la richesse et aux ressources financières.",
                            "Totalitarisme": "Un système politique dans lequel le gouvernement exerce un contrôle total sur tous les aspects de la vie des citoyens, y compris la politique, l'économie, la culture et la société.",
                            "Anarchie": "Une absence de gouvernement formel ou d'autorité politique, où l'ordre est maintenu par des accords volontaires entre les individus ou les groupes.",
                            "Fédéralisme": "Un système politique dans lequel le pouvoir est partagé entre un gouvernement central et des entités subnationales, telles que des États ou des provinces, qui conservent une certaine autonomie politique.",
                            "Militarisme": "Un système politique dans lequel le pouvoir est partagé entre un gouvernement central et des entités subnationales, telles que des États ou des provinces, qui conservent une certaine autonomie politique.",
                            "Autarcie": "Un système politique dans lequel un pays cherche à être économiquement autonome en produisant tous les biens et services nécessaires sur son propre territoire, souvent en fermant ses frontières aux échanges internationaux."]
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let id = data.getLastId()
        
        
        popCouleur.addTarget(self, action: #selector(colorChanged), for: .valueChanged)
        popCouleur.selectedColor = UIColor(cgColor: CGColor(
            red: CGFloat(data.getPlanetParameter(id: id, parametre: data.color_r) ?? 0) / 255,
            green: CGFloat(data.getPlanetParameter(id: id, parametre: data.color_g) ?? 0) / 255,
            blue: CGFloat(data.getPlanetParameter(id: id, parametre: data.color_b) ?? 0) / 255,
            alpha: 1))
        
        print(CGFloat(data.getPlanetParameter(id: id, parametre: data.color_r) ?? 0))
        print(CGFloat(data.getPlanetParameter(id: id, parametre: data.color_g) ?? 0))
        print(CGFloat(data.getPlanetParameter(id: id, parametre: data.color_b) ?? 0))
        
        popCouleurPresentation.layer.backgroundColor = popCouleur.selectedColor?.cgColor
        
        for button in shadowButtons {
            button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.40).cgColor
            button.layer.shadowOpacity = 0.9
            button.layer.shadowOffset = CGSize(width: 1.5, height: 4.0)
            button.layer.shadowRadius = 2
            button.layer.cornerRadius = 4.0
        }
       
        let actionAspectExplicationsClosure = { (action: UIAction) in
            self.aspectExplication.text = self.dataSourceAspect[action.title]
        }
        let actionRegimeExplicationsClosure = { (action: UIAction) in
            self.regimeExplication.text = self.dataSourceRegime[action.title]
        }
        
        let defaultAspect = (data.getPlanetParameter(id: id, parametre: data.aspect) ?? "Humanoïde") as String
        
        var menuChildrenAspect: [UIMenuElement] = []
        for element in dataSourceAspect {
            let action = UIAction(title: element.0, handler: actionAspectExplicationsClosure)
               if element.0 == defaultAspect {
                   action.state = .on
               }
               menuChildrenAspect.append(action)
        }
        
        aspectButton.menu = UIMenu(options: .displayInline, children: menuChildrenAspect)
        
        aspectButton.showsMenuAsPrimaryAction = true
        aspectButton.changesSelectionAsPrimaryAction = true
           
        aspectButton.frame = CGRect(x: 160, y: 286, width: 126, height: 30)
        aspectButton.layer.backgroundColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        aspectButton.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        aspectButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.40).cgColor
        aspectButton.layer.shadowOpacity = 0.9
        aspectButton.layer.shadowOffset = CGSize(width: 1.5, height: 4.0)
        aspectButton.layer.shadowRadius = 2
        aspectButton.layer.cornerRadius = 4.0
        aspectButton.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        aspectButton.layer.borderWidth = 1.0
        aspectButton.titleLabel?.font = UIFont(name: "Marker Felt Wide", size: 17.0)
        aspectButton.tag = 1
        self.view.addSubview(aspectButton)
        aspectExplication.text = dataSourceAspect.first(where: { $0.0 == defaultAspect })?.1 ?? ""
        
        aspectButton.addObserver(self, forKeyPath: "titleLabel.text", options: .new, context: nil)
        
        let defaultPol = (data.getPlanetParameter(id: id, parametre: data.politique) ?? "Ploutocratie") as String
        
        var menuChildrenRegime: [UIMenuElement] = []
        for element in dataSourceRegime {
            let action = UIAction(title: element.0, handler: actionRegimeExplicationsClosure)
               if element.0 == defaultPol {
                   action.state = .on
               }
               menuChildrenRegime.append(action)
        }
        regimeButton.menu = UIMenu(options: .displayInline, children: menuChildrenRegime)
        regimeButton.showsMenuAsPrimaryAction = true
        regimeButton.changesSelectionAsPrimaryAction = true
           
        regimeButton.frame = CGRect(x: 160, y: 426, width: 126, height: 30)
        regimeButton.layer.backgroundColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        regimeButton.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        regimeButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.40).cgColor
        regimeButton.layer.shadowOpacity = 0.9
        regimeButton.layer.shadowOffset = CGSize(width: 1.5, height: 4.0)
        regimeButton.layer.shadowRadius = 2
        regimeButton.layer.cornerRadius = 4.0
        regimeButton.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        regimeButton.layer.borderWidth = 1.0
        regimeButton.titleLabel?.font = UIFont(name: "Marker Felt Wide", size: 17.0)
        regimeButton.tag = 2
        self.view.addSubview(regimeButton)
        regimeExplication.text = dataSourceRegime.first(where: { $0.0 == defaultPol })?.1 ?? ""
        
        regimeButton.addObserver(self, forKeyPath: "titleLabel.text", options: .new, context: nil)
        
        SpaciesName.placeholder = data.getPlanetParameter(id: data.getLastId(), parametre: data.habitantName)
        
        Language.placeholder = data.getPlanetParameter(id: data.getLastId(), parametre: data.langue)
    }
    
    @objc private func changeAspect(){
        print("aa")
    }
    
    @objc private func colorChanged() {
        popCouleurPresentation.layer.backgroundColor = popCouleur.selectedColor?.cgColor
        
        var r : CGFloat = 0
        var g : CGFloat = 0
        var b : CGFloat = 0
        var a: CGFloat = 0
        let bgColor = popCouleurPresentation.backgroundColor!
        bgColor.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        data.setPlanetParameter(id: data.getLastId(), parametre: data.color_r, value: Int(r * 255))
        
        data.setPlanetParameter(id: data.getLastId(), parametre: data.color_g, value: Int(g * 255))
        
        data.setPlanetParameter(id: data.getLastId(), parametre: data.color_b, value: Int(b * 255))
    }
    
    
    
    @IBAction func ChooseNom(_ sender: UITextField) {
        data.setPlanetParameter(id: data.getLastId(), parametre: data.habitantName, value: sender.text!)

    }
    
    @IBAction func ChooseLangue(_ sender: UITextField) {
        data.setPlanetParameter(id: data.getLastId(), parametre: data.langue, value: sender.text!)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let object = object as? UIButton, let keyPath = keyPath, keyPath == "titleLabel.text" {
            let newTitle = change?[.newKey] as? String
            if(object.tag == 1){
                data.setPlanetParameter(id: data.getLastId(), parametre: data.aspect, value: newTitle!)
            }else if (object.tag == 2){
                data.setPlanetParameter(id: data.getLastId(), parametre: data.politique, value: newTitle!)
            }
        }
    }
    
    @IBAction func NextPage(_ sender: UIButton) {}
    
    @IBAction func CaractereChoose(_ sender: UIButton) {
        let tag = sender.tag
        
        if caractereChoisies.contains(sender.titleLabel?.text) == false {
            caractereChoisies.append(sender.titleLabel?.text)
            sender.configuration?.baseForegroundColor = UIColor(red: 217/255, green: 169/255, blue: 255/255, alpha: 1);
            sender.layer.borderColor = CGColor(red: 217/255, green: 169/255, blue: 255/255, alpha: 1)
            sender.layer.borderWidth = 3
            sender.layer.cornerRadius = 16
            sender.layer.cornerCurve = .continuous
        } else {
            let indexElement = caractereChoisies.firstIndex(of: sender.titleLabel?.text)
            caractereChoisies.remove(at: indexElement!)
            sender.configuration?.baseForegroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1);
            sender.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0)
            sender.layer.borderWidth = 1
        }
    }
}
        
