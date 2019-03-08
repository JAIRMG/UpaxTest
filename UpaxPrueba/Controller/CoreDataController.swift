//
//  CoreDataController.swift
//  UpaxPrueba
//
//  Created by Jair Moreno Gaspar on 3/7/19.
//  Copyright © 2019 Jair Moreno Gaspar. All rights reserved.
//

import UIKit
import CoreData

class CoreDataController: UIViewController  {
    
    
    //MARK: Properties:
    var respuestas: [Respuestas] = []
    let cellId = "cellId"
    let key = "saved"
    var respuestasRecuperadas: [Respuestas] = []
    
    lazy var tableView: UITableView = {
        
        var tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
        
    }()

    //MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureNavigationBar()
        saveInCoreData()
        retrieveData()
        setUpViews()
        
    }
    
    
    //MARK: Functions
    
    func setUpViews(){
        
        tableView.frame = view.frame
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
    }
    
    func configureNavigationBar(){
        navigationController?.navigationBar.barTintColor = .blue
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barStyle = .black
        navigationItem.title = "CoreData"
    }
    
    func saveInCoreData(){
        
        let saved = UserDefaults.standard.bool(forKey: key)
        
        respuestas.append(Respuestas(id: 1, nombre: "Miguel Cervantes", fechaNac: "8/Dic/1990", posicion: "Desarrollador", alias: "preg1"))
        respuestas.append(Respuestas(id: 2, nombre: "Juan Morales", fechaNac: "03/Jul/1990", posicion: "Diseñador", alias: "preg2"))
        respuestas.append(Respuestas(id: 3, nombre: "Roberto Méndez", fechaNac: "14/Dic/1990", posicion: "Desarrollador", alias: "preg3"))
        respuestas.append(Respuestas(id: 4, nombre: "Miguel Cuevas", fechaNac: "08/Dic/1990", posicion: "Programador", alias: "preg4"))
        
        if !saved {
            
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let userEntity = NSEntityDescription.entity(forEntityName: "Respuesta", in: managedContext)!
            
            for i in 0..<4{
                let respuesta = NSManagedObject(entity: userEntity, insertInto: managedContext)
                respuesta.setValue(respuestas[i].id, forKeyPath: "id")
                respuesta.setValue(respuestas[i].nombre, forKey: "nombre")
                respuesta.setValue(respuestas[i].fechaNac, forKey: "fechaNac")
                respuesta.setValue(respuestas[i].posicion, forKey: "posicion")
                respuesta.setValue(respuestas[i].alias, forKey: "alias")
            }
            
            do {
                try managedContext.save()
                print("guardado correctamente")
                UserDefaults.standard.set(true, forKey: key)
                
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            
        }
        
    }
    
    func retrieveData(){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Prepare the request of type NSFetchRequest  for the entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Respuesta")
        

        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                
                let id = data.value(forKey: "id") as! Int
                let nombre = data.value(forKey: "nombre") as! String
                let fechaNac = data.value(forKey: "fechaNac") as! String
                let posicion = data.value(forKey: "posicion") as! String
                let alias = data.value(forKey: "alias") as! String
                
                respuestasRecuperadas.append(Respuestas(id: id, nombre: nombre, fechaNac: fechaNac, posicion: posicion, alias: alias))
                
                print(data.value(forKey: "id") as! Int)
                print(data.value(forKey: "nombre") as! String)
                print(data.value(forKey: "fechaNac") as! String)
            }
            
        } catch {
            
            print("Failed")
        }
        
        
    }
    
}

extension CoreDataController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return respuestasRecuperadas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        //cell.textLabel?.text = respuestas[indexPath.item].nombre
        let response = respuestasRecuperadas[indexPath.row]
        cell.textLabel?.text = "\(response.id ?? 0) -\(response.nombre ?? "nombre") - \(response.fechaNac ?? "fechaNac") - \(response.posicion ?? "posición") - \(response.alias ?? "alias")"
        return cell
    }
    
    
}
