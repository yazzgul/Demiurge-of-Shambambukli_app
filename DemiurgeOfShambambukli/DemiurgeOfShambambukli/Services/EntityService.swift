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

    private let lock = NSLock()

    @Published var entities: [Entity] = [
        Entity(name: "Жизнь", description: "Ку-ку!", image: UIImage(named: "chicken"))
    ]

    func saveEntity(entity: Entity) {
        if !entities.contains(where: { $0.id == entity.id }) {
            entities.append(entity)
        }
    }

//    func saveEntity(entity: Entity) {
//        lock.lock()
//        if !entities.contains(where: { $0.id == entity.id }) {
//            entities.append(entity)
//        }
//        lock.unlock()
//    }
    func removeEntity(at index: Int) {
        lock.lock()
        entities.remove(at: index)
        lock.unlock()
    }
    func removeEntity(with entity: Entity) {
        if let index = entities.firstIndex(of: entity) {
            entities.remove(at: index)
        }
    }
//    func removeEntity(with entity: Entity) {
//        lock.lock()
//        if let index = entities.firstIndex(of: entity) {
//            entities.remove(at: index)
//        }
//        lock.unlock()
//    }
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
