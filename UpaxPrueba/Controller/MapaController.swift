//
//  MapaController.swift
//  UpaxPrueba
//
//  Created by Jair Moreno Gaspar on 3/7/19.
//  Copyright © 2019 Jair Moreno Gaspar. All rights reserved.
//

import UIKit
import GoogleMaps

class MapaController: UIViewController, GMSMapViewDelegate {
   
    //MARK: Properties
    var mapa: GMSMapView!
    var camera = GMSCameraPosition()
    

    
    let campoLat: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .white
        tf.allowsEditingTextAttributes = true
        tf.layer.cornerRadius = 10
        tf.clipsToBounds = false
        tf.layer.shadowRadius = 3.0
        tf.layer.shadowColor = UIColor.black.cgColor
        tf.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        tf.layer.shadowOpacity = 1.0
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Latitud"
        tf.textAlignment = .center
        return tf
    }()
    
    let campoLong: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .white
        tf.layer.cornerRadius = 10
        tf.clipsToBounds = false
        tf.layer.shadowRadius = 3.0
        tf.layer.shadowColor = UIColor.black.cgColor
        tf.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        tf.layer.shadowOpacity = 1.0
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Longitud"
        tf.textAlignment = .center
        return tf
    }()
    
    //MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setUpViews()
        configureNavigationBar()
        
    }
    
    
    //MARK: Function
    
    func setUpViews(){
        
        
        let miUbicacion = obtener_ubicacion()
        
        if(!revisarPermisosLocalizacion()){
            
            camera = GMSCameraPosition.camera(withLatitude: 19.3039965, longitude: -99.2108294, zoom: 11.12)
            //showAlertaParaActivarLocalizacion()
            
        } else {
            camera = GMSCameraPosition.camera(withLatitude: miUbicacion.coordinate.latitude, longitude: miUbicacion.coordinate.longitude, zoom: 14.0)
        }
        
        mapa = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapa.isMyLocationEnabled = true
        mapa.delegate = self
        mapa.settings.myLocationButton = true
        
        customMap()
        
        //Para habilitar el textfield en el mapa
        for gesture in mapa.gestureRecognizers! {
            mapa.removeGestureRecognizer(gesture)
        }
        
        
        view.addSubview(mapa)
        mapa.translatesAutoresizingMaskIntoConstraints = false
        mapa.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mapa.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapa.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mapa.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        campoLat.delegate = self
        campoLat.returnKeyType = UIReturnKeyType.continue
        mapa.addSubview(campoLat)
        campoLat.centerXAnchor.constraint(equalTo: mapa.centerXAnchor).isActive = true
        campoLat.topAnchor.constraint(equalTo: mapa.topAnchor, constant: 110).isActive = true
        campoLat.widthAnchor.constraint(equalToConstant: 250).isActive = true
        campoLat.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        campoLong.delegate = self
        campoLong.returnKeyType = UIReturnKeyType.done
        mapa.addSubview(campoLong)
        campoLong.centerXAnchor.constraint(equalTo: campoLat.centerXAnchor).isActive = true
        campoLong.topAnchor.constraint(equalTo: campoLat.bottomAnchor, constant: 10).isActive = true
        campoLong.widthAnchor.constraint(equalToConstant: 250).isActive = true
        campoLong.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    func configureNavigationBar(){
        navigationController?.navigationBar.barTintColor = .blue
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barStyle = .black
        navigationItem.title = "Mapa"
    }
    

    
    func customMap(){
        do {
            // Set the map style by passing the URL of the local file.
            if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                mapa.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
                
            } else {
                print("error al encontrar style.json")
            }
        } catch {
            print("Error en los estilos \(error)")
        }
    }
    
    
    
    func validarCampos(latitud: String, longitud: String){
        print("valores: \(latitud), \(longitud)")
        
        if latitud.isFloat && longitud.isFloat {
            print("correcto")
            
            
            
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: Double(Float(latitud)!), longitude: Double(Float(longitud)!))
            
            marker.map = self.mapa
            
            let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: marker.position.latitude, longitude: marker.position.longitude, zoom: 14.0)
            
            mapa.animate(to: camera)
            
            
        } else {
            let alert = UIAlertController(title: "Error", message: "Formato de coordenadas incorrectas", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
}

extension MapaController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       
        if textField == campoLat{
            campoLong.becomeFirstResponder()
        }
        
        if textField == campoLong {
            
            validarCampos(latitud: campoLat.text ?? "", longitud: campoLong.text ?? "")
            campoLong.resignFirstResponder()
        }
        
        return true
    }

    
}


