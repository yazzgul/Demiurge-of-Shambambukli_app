//
//  MainViewModel.swift
//  DemiurgeOfShambambukli
//
//  Created by Язгуль Хасаншина on 14.09.2024.
//

import UIKit

class MainViewModel {

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
