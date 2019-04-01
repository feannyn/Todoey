//
//  ToDoListModel.swift
//  Todoey
//
//  Created by Nicholas Feanny on 3/30/19.
//  Copyright © 2019 Nicholas Feanny. All rights reserved.
//

import Foundation

class Item: Encodable {
    var job: String = ""
    var complete: Bool = false
}

