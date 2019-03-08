//
//  ImageCell.swift
//  UpaxPrueba
//
//  Created by Jair Moreno Gaspar on 3/7/19.
//  Copyright © 2019 Jair Moreno Gaspar. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    let imagen: UIImageView = {
        let imagen = UIImageView()
        imagen.clipsToBounds = true
        imagen.backgroundColor = .blue
        imagen.translatesAutoresizingMaskIntoConstraints = false
        return imagen
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews(){
        
        addSubview(imagen)
        imagen.topAnchor.constraint(equalTo: self.topAnchor, constant: 10)
        imagen.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        imagen.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
        imagen.widthAnchor.constraint(equalToConstant: 100)
        
        
    }
    
    func configure(with userModel: User){
        
        
        
    }
    
}
