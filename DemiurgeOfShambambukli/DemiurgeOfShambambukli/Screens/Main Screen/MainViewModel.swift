//
//  MainViewModel.swift
//  DemiurgeOfShambambukli
//
//  Created by Язгуль Хасаншина on 14.09.2024.
//

import UIKit
import Combine

class MainViewModel {

    @Published var deadStateEntityCount = 0

    var entitiesPublisher: AnyPublisher<[Entity], Never> {
        return EntityService.shared.$entities
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    func createLivingEntity() -> Entity {
        createNewEntity(with: .life)
    }

    func createNewEntity(with lifeState: LifeState) -> Entity {

        let name = lifeState.rawValue
        let description = lifeState.description
        let imageName = lifeState.imageName

        let entityImage = UIImage(named: imageName)
        let entity = Entity(name: name, description: description, image: entityImage)

        EntityService.shared.saveEntity(entity: entity)

        return entity
    }


// функции для рандомайзера состояний "мертвый"/"живой"
    func getRandomEntityLifeState() -> LifeState {
//        let randomNumber = (Int.random(in: 1...2))
        let randomNumber = 1
        if randomNumber == 1 {
            deadStateEntityCount += 1
            return .dead
        }
        deadStateEntityCount = 0
        return .alive
    }

    func killLivingEntityByDeadStateEntities() {
        let entitiesCount = EntityService.shared.getCount()
        print("entity 1 " , EntityService.shared.getCount())
        if entitiesCount >= 4 {
            let checkingEntity = EntityService.shared.entities[entitiesCount - 4]
            print("entity 2 \(checkingEntity.name), \(LifeState.life.rawValue)" , EntityService.shared.getCount())

            if checkingEntity.name == "Жизнь" {
                EntityService.shared.removeEntity(with: checkingEntity)
                print("entity 3 \(checkingEntity.name), \(LifeState.life.rawValue)" , EntityService.shared.getCount())
            }

        }

    }

}
// функции для работы с таблицей
extension MainViewModel {

    func numberOfRowsInSection() -> Int {
        EntityService.shared.getCount()
    }

    func configureCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reuseIdentifier, for: indexPath) as? MainTableViewCell
        guard let cell = cell else { return UITableViewCell() }

//        let entity = entities[indexPath.row]
        let entity = EntityService.shared.entities[indexPath.row]
//        let entity = EntityService.shared.getEntity(at: indexPath.row)

        if let image = entity.image {
            cell.configureCell(with: image)
        }
        cell.configureCell(with: entity)

        return cell
    }
}
