//
//  Respuestas.swift
//  UpaxPrueba
//
//  Created by Jair Moreno Gaspar on 3/7/19.
//  Copyright © 2019 Jair Moreno Gaspar. All rights reserved.
//

import UIKit

class Respuestas {
    var id: Int?
    var nombre: String?
    var fechaNac: String?
    var posicion: String?
    var alias: String?
    
    init(id: Int, nombre: String, fechaNac: String, posicion: String, alias: String) {
        self.id = id
        self.nombre = nombre
        self.fechaNac = fechaNac
        self.posicion = posicion
        self.alias = alias
        
    }
    
}
