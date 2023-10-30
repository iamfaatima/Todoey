//
//  Data Model.swift
//  Todoey
//
//  Created by Dev on 29/10/2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct Items: Codable{
    var title : String = ""
    var done : Bool = false
}
