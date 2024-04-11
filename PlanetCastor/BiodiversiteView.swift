//
//  BiodiversiteView.swift
//  PlanetCastor
//
//  Created by Ivan Rocque on 10/04/2024.
//

import Foundation
import UIKit

class BiodiversiteView: UIViewController {
    
    var name : String = ""
    
    var count : Int = 2
    
    @IBOutlet weak var PageTitle: UILabel!
    var images: [UIImageView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PageTitle.text = name
        
        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
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
        
        
        let spacies = Database.shared.getBiodivSpacies(type: name)
        count = spacies.count
        
        var stackViewHori : UIStackView
        
        let divider = checkFirstDivider(nb: count)
        
        let countModulo = Int(count/divider)
        
        let width = 393 / divider
        let height = (356 * width) / 393
        
        var id = 0
        
        print(divider)
        print(countModulo)
        
        for _ in 1...countModulo{
            stackViewHori = UIStackView()
            stackView.addArrangedSubview(stackViewHori)
            stackViewHori.axis = .horizontal
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
            stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
            
            for _ in 1...divider{
                let imageView = UIImageView()
                imageView.image = UIImage(named: spacies[id])
                stackViewHori.addArrangedSubview(imageView)
                imageView.widthAnchor.constraint(equalToConstant: CGFloat(width)).isActive = true
                imageView.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
                
                images.append(imageView)
                id += 1
            }
        }
        
        
    }
    
    func checkFirstDivider(nb : Int) -> Int{
        
        if(nb == 1){
            return 1
        }
        
        var divider = 2
        var modulo = -1
        while modulo != 0{
            divider += 1
            modulo = nb % divider
        }
        
        print(divider)
        
        
        if(divider == nb){
            divider = 1
        }
        
        return divider
    }
    
}
