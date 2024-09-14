//
//  Entity.swift
//  DemiurgeOfShambambukli
//
//  Created by Язгуль Хасаншина on 14.09.2024.
//

import UIKit

struct Entity: Hashable, Identifiable {
    var id: UUID = UUID()
    var name: String
    var description: String
    var image: UIImage?
}

