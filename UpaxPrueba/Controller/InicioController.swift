//
//  ViewController.swift
//  UpaxPrueba
//
//  Created by Jair Moreno Gaspar on 3/7/19.
//  Copyright © 2019 Jair Moreno Gaspar. All rights reserved.
//

import UIKit

class InicioController: UIViewController {

    //MARK: Properties
    
    let botonMapa: UIButton = {
        let boton = UIButton()
        boton.backgroundColor = .black
        boton.addTarget(self, action: #selector(goToMapa(_:)), for: .touchUpInside)
        boton.tag = 1
        boton.setTitle("Mapa", for: .normal)
        boton.titleLabel?.font = .systemFont(ofSize: 17)
        boton.setTitleColor(UIColor.white, for: .normal)
        boton.layer.cornerRadius = 10
        boton.translatesAutoresizingMaskIntoConstraints = false
        return boton

    }()
    
    let botonServicio: UIButton = {
        let boton = UIButton()
        boton.backgroundColor = .black
        boton.tag = 2
        boton.addTarget(self, action: #selector(goToMapa(_:)), for: .touchUpInside)
        boton.setTitle("Servicio", for: .normal)
        boton.titleLabel?.font = .systemFont(ofSize: 17)
        boton.setTitleColor(UIColor.white, for: .normal)
        boton.layer.cornerRadius = 10
        boton.translatesAutoresizingMaskIntoConstraints = false
        return boton
        
    }()
    
    let botonCoreData: UIButton = {
        let boton = UIButton()
        boton.backgroundColor = .black
        boton.addTarget(self, action: #selector(goToMapa(_:)), for: .touchUpInside)
        boton.tag = 3
        boton.setTitle("CoreData", for: .normal)
        boton.titleLabel?.font = .systemFont(ofSize: 17)
        boton.setTitleColor(UIColor.white, for: .normal)
        boton.layer.cornerRadius = 10
        boton.translatesAutoresizingMaskIntoConstraints = false
        return boton
        
    }()
    
    //MARK: Init
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setUpViews()
        configureNavigationBar()
        
    }


    
    //MARK: Functions
    
    func setUpViews(){
        
        //Constraints
        view.addSubview(botonMapa)
        self.botonMapa.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.botonMapa.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        self.botonMapa.widthAnchor.constraint(equalToConstant: 200).isActive = true
        self.botonMapa.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(botonServicio)
        self.botonServicio.centerXAnchor.constraint(equalTo: botonMapa.centerXAnchor).isActive = true
        self.botonServicio.topAnchor.constraint(equalTo: botonMapa.bottomAnchor, constant: 40).isActive = true
        self.botonServicio.widthAnchor.constraint(equalToConstant: 200).isActive = true
        self.botonServicio.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(botonCoreData)
        self.botonCoreData.centerXAnchor.constraint(equalTo: botonServicio.centerXAnchor).isActive = true
        self.botonCoreData.topAnchor.constraint(equalTo: botonServicio.bottomAnchor, constant: 40).isActive = true
        self.botonCoreData.widthAnchor.constraint(equalToConstant: 200).isActive = true
        self.botonCoreData.heightAnchor.constraint(equalToConstant: 50).isActive = true

        
        
    }
    
    @objc func goToMapa(_ sender: UIButton){
        var siguienteController: UIViewController!
        switch sender.tag {
        case 1:
            print("mapa")
            siguienteController = MapaController()
        case 2:
            print("servicio")
            siguienteController = ServicioController()
        case 3:
            print("coreData")
            siguienteController = CoreDataController()

        default:
            break
        }
        
        self.navigationController?.pushViewController(siguienteController, animated: true)
        
    }
    
    func configureNavigationBar(){
        navigationController?.navigationBar.barTintColor = .blue
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barStyle = .black
        navigationItem.title = "Inicio"
    }
    
}

