//
//  Entity.swift
//  DemiurgeOfShambambukli
//
//  Created by Язгуль Хасаншина on 14.09.2024.
//

import UIKit

struct Entity: Hashable, Identifiable, Equatable {
    var id: UUID = UUID()
    var name: String
    var description: String
    var image: UIImage?

    static func == (lhs: Entity, rhs: Entity) -> Bool {
        return lhs.id == rhs.id
    }

}

enum LifeState: String {
    case dead = "Мёртвая"
    case alive = "Живая"
    case life = "Жизнь"

    var description: String {
        switch self {
        case .dead:
            return "или прикидывается"
        case .alive:
            return "и шевелится!"
        case .life:
            return "Ку-ку!"
        }
    }

    var imageName: String {
        switch self {
        case .dead:
            return "skull"
        case .alive:
            return "firework"
        case .life:
            return "chicken"
        }
    }
}

