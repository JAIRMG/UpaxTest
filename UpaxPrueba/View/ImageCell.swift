//
//  ImageCell.swift
//  UpaxPrueba
//
//  Created by Jair Moreno Gaspar on 3/7/19.
//  Copyright © 2019 Jair Moreno Gaspar. All rights reserved.
//

import UIKit
import AlamofireImage

class ImageCell: UICollectionViewCell {
    
    let imagen: UIImageView = {
        let imagen = UIImageView()
        imagen.clipsToBounds = true
        imagen.translatesAutoresizingMaskIntoConstraints = false
        return imagen
    }()
    
    let texto: UILabel = {
        let tv = UILabel()
        tv.textColor = .black
        tv.textAlignment = .left
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
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
        imagen.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imagen.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        imagen.widthAnchor.constraint(equalToConstant: 100)
        
        addSubview(texto)
        texto.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        texto.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 120).isActive = true
        texto.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        
        
    }
    
    func configure(with datos: Data){
        
        guard let url = URL(string: datos.avatar!) else { return }
        
        imagen.af_setImage(withURL: url)
        texto.text = "\(datos.first_name ?? "name") \(datos.last_name ?? "last name")"
        
    }
    
}
