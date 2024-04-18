//
//  GalerieScrollView.swift
//  PlanetCastor
//
//  Created by Ivan Rocque on 17/04/2024.
//

import Foundation
import UIKit

class GalerieScrollView: UIViewController {
    
    
    var planetButton : [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let data = Database.shared
        
        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 118).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor , constant: -20).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        let stackView = UIStackView()
        scrollView.addSubview(stackView)
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        var count = data.getLastId()
        let planetCount = count
        
        if(count % 2 != 0){
            count += 1
        }
        var i = 0
        
        var stackViewHori : UIStackView
        
        for _ in 1...Int(count/2){
            stackViewHori = UIStackView()
            stackView.addArrangedSubview(stackViewHori)
            stackViewHori.axis = .horizontal
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
            stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
            
            for j in 1...2{
                i += 1
                let button = UIButton()
                
                if(i <= planetCount){
                    
                    var name : String = "Terrestre"
                    
                    
                   if(i <= data.getLastId()){
                       name = (data.getPlanetParameter(id: i, parametre: data.type)?.uppercased())!
                    }
                    let namel = name.lowercased()
                    
                    let img = "Planete\(name.prefix(1) + (name.suffix(namel.count - 1)).lowercased())"
                    
                    button.isUserInteractionEnabled = true
                    button.setImage(UIImage(named: img), for: .normal)
                    button.contentMode = .scaleAspectFill
                    button.tag = i;
                    button.layer.backgroundColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
                    button.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
                }else{
                    button.isUserInteractionEnabled = false
                    button.layer.backgroundColor = CGColor(red: 1, green: 1, blue: 1, alpha: 0)
                    button.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0)
                }
                button.layer.borderWidth = 1
                button.layer.cornerRadius = 16
                button.widthAnchor.constraint(equalToConstant: CGFloat(163)).isActive = true
                button.heightAnchor.constraint(equalToConstant: CGFloat(156)).isActive = true
                
                stackViewHori.addArrangedSubview(button)
                
                planetButton.append(button)
                
                if(i <= planetCount){
                    let textView = UITextView()
                    textView.text = data.getPlanetParameter(id: i, parametre: data.planetname)?.uppercased()
                    textView.textAlignment = .center
                    textView.isEditable = false
                    textView.textColor = UIColor.black
                    textView.font = UIFont(name: "MarkerFelt-Wide", size: 20)
                    textView.sizeToFit()
                    
                    
                    textView.center = CGPoint(x: 81.5, y: 78)
                    
                    button.addSubview(textView)
                }
               
                
                if(j == 1){
                    let button = UIButton()
                    button.isUserInteractionEnabled = false
                    button.contentMode = .scaleAspectFit
                    button.layer.backgroundColor = CGColor(red: 1, green: 1, blue: 1, alpha: 0)
                    button.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0)
                    button.layer.borderWidth = 1
                    button.layer.cornerRadius = 16
                    button.widthAnchor.constraint(equalToConstant: CGFloat(26)).isActive = true
                    button.heightAnchor.constraint(equalToConstant: CGFloat(156)).isActive = true
                    
                    stackViewHori.addArrangedSubview(button)
                }
            }
            
            let button = UIButton()
            button.isUserInteractionEnabled = false
            button.contentMode = .scaleAspectFit
            button.layer.backgroundColor = CGColor(red: 1, green: 1, blue: 1, alpha: 0)
            button.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0)
            button.layer.borderWidth = 1
            button.layer.cornerRadius = 16
            button.widthAnchor.constraint(equalToConstant: CGFloat(26)).isActive = true
            button.heightAnchor.constraint(equalToConstant: CGFloat(26)).isActive = true
            
            stackView.addArrangedSubview(button)
            
        }
        
        
        
        for button in planetButton{
            let tabGesture = UITapGestureRecognizer(target: self, action: #selector(choosePlanet(_:)))
            button.addGestureRecognizer(tabGesture)
        }
    }
    
    @objc func choosePlanet(_ sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view2 = storyboard.instantiateViewController(withIdentifier: "glrView") as! GalerieParameter
        
        let btn = sender.view as! UIButton
        
        PlanetShow.shared.planetToShowId = btn.tag
        view2.modalPresentationStyle = .fullScreen
        present(view2, animated: false, completion: nil)
    }
}
