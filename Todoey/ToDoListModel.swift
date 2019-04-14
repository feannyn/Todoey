//
//  ToDoListModel.swift
//  Todoey
//
//  Created by Nicholas Feanny on 3/30/19.
//  Copyright © 2019 Nicholas Feanny. All rights reserved.
//

import Foundation

class Item: Encodable, Decodable { //these 2 protocols were kept for interpretation but can be replaced with codable
    var job: String = ""
    var complete: Bool = false
}

