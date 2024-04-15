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
                imageView.isUserInteractionEnabled = true
                imageView.image = UIImage(named: spacies[id])
                stackViewHori.addArrangedSubview(imageView)
                imageView.widthAnchor.constraint(equalToConstant: CGFloat(width)).isActive = true
                imageView.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
                
                images.append(imageView)
                id += 1
            }
        }
        
        for image in images{
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(spawnImage(_:)))
            image.addGestureRecognizer(tapGesture)
        }
    }
    
    func checkFirstDivider(nb : Int) -> Int{
        
        if(nb == 1){
            return 1
        }else if(nb % 5 == 0){
            return 5
        }else if(nb % 4 == 0){
            return 4
        }else if(nb % 3 == 0){
            return 3
        }else if(nb % 2 == 0){
            return 2
        }else{
            return 1
        }
    }
    
    @objc func spawnImage(_ sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view2 = storyboard.instantiateViewController(withIdentifier: "Environnement") as! ImageParameter
        
        let img = sender.view as! UIImageView
        let name = (img.image?.imageAsset?.value(forKey: "assetName"))!
        
        view2.imageToSpawn = name as! String
        view2.modalPresentationStyle = .fullScreen
        present(view2, animated: false, completion: nil)
    }
    
}
