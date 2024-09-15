//
//  EntityService.swift
//  DemiurgeOfShambambukli
//
//  Created by Язгуль Хасаншина on 14.09.2024.
//

// MARK: - класс для работы с сущностями Entity и их хранения
import UIKit
import Combine

class EntityService {

    public static let shared = EntityService()

    private init() {}

    @Published var entities: [Entity] = []

    func saveEntity(entity: Entity) {
        if !entities.contains(where: { $0.id == entity.id }) {
            entities.append(entity)
        }
    }
    func removeEntity(at index: Int) {
        entities.remove(at: index)
    }
    func removeEntity(with entity: Entity) {
        if let index = entities.firstIndex(of: entity) {
            entities.remove(at: index)
        }
    }
    func getEntity(at index: Int) -> Entity {
        return entities[index]
    }
    func getEntity(by id: UUID) -> Entity? {
        if let entity = entities.first(where: { $0.id == id }) {
            return entity
        }
        return nil
    }
    func getCount() -> Int{
        entities.count
    }
    func entitiesAreEmpty() -> Bool {
        entities.isEmpty
    }
    
}
