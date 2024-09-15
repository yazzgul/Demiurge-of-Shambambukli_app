//
//  MainViewModel.swift
//  DemiurgeOfShambambukli
//
//  Created by Язгуль Хасаншина on 14.09.2024.
//

import UIKit
import Combine

class MainViewModel {

//  счетчики для состояний "мертвый"/"живой"
    @Published var deadStateEntityCount = 0
    @Published var aliveStateEntityCount = 0

//  паблишер для слежки за массивом Entity в EntityService
    var entitiesPublisher: AnyPublisher<[Entity], Never> {
        return EntityService.shared.$entities
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
//  функция для создания Entity с состоянием "Жизнь" LifeState.life
    func createLivingEntity() {
        aliveStateEntityCount = 0
        createNewEntity(with: .life)
    }
//  функция для создания новых Entity
    func createNewEntity(with lifeState: LifeState) {
        let name = lifeState.rawValue
        let description = lifeState.description
        let imageName = lifeState.imageName

        let entityImage = UIImage(named: imageName)
        let entity = Entity(name: name, description: description, image: entityImage)

        EntityService.shared.saveEntity(entity: entity)
    }
// функция для рандомайзера состояний "мертвый"/"живой"
    func getRandomEntityLifeState() -> LifeState {
        let randomNumber = (Int.random(in: 1...2))
        if randomNumber == 1 {
            deadStateEntityCount += 1
            aliveStateEntityCount = 0
            return .dead
        }
        deadStateEntityCount = 0
        aliveStateEntityCount += 1
        return .alive
    }
//  функция для удаления Entity с состоянием "Жизнь" (если идут подряд 3 сущности с состоянием "Мертвый")
    func killLivingEntityByDeadStateEntities() {
        let entitiesCount = EntityService.shared.getCount()

        if entitiesCount >= 4 {
            let checkingEntity = EntityService.shared.entities[entitiesCount - 4]

            if checkingEntity.name == LifeState.life.rawValue {
                EntityService.shared.removeEntity(with: checkingEntity)
            }
        }
    }

    func entitiesAreEmptyArray() -> Bool {
        EntityService.shared.entitiesAreEmpty()
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

//        let entity = EntityService.shared.entities[indexPath.row]
        let entity = EntityService.shared.getEntity(at: indexPath.row)

        if let image = entity.image {
            cell.configureCell(with: image)
        }
        cell.configureCell(with: entity)

        return cell
    }
}
