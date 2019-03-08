//
//  User.swift
//  UpaxPrueba
//
//  Created by Jair Moreno Gaspar on 3/7/19.
//  Copyright © 2019 Jair Moreno Gaspar. All rights reserved.
//

import UIKit

struct User: Decodable {
    var page: Int?
    var per_page: Int?
    var total: Int?
    var total_pages: Int?
    var data: [Data]?
}

struct Data: Decodable {    
    var id: Int?
    var first_name: String?
    var last_name: String?
    var avatar: String?
}
