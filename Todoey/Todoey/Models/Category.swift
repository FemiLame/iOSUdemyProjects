//
//  Category.swift
//  Todoey
//
//  Created by Alex Osipova on 11.08.2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var hexColor: String?
    let items = List<Item>()
}
