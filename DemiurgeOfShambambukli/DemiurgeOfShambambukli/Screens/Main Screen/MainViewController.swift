//
//  ViewController.swift
//  DemiurgeOfShambambukli
//
//  Created by Язгуль Хасаншина on 14.09.2024.
//

import UIKit
import Combine

class MainViewController: UIViewController {
    private let contentView: MainView = .init()
    private let viewModel: MainViewModel

    private var cancellables = Set<AnyCancellable>()

    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        contentView.entityCreationButtonDelegate = self
        contentView.setupDataSource(self)
        contentView.setupDelegate(self)

        updateEntitiesOnTable()
        checkDeadStateEntities()
        checkAliveStateEntities()
    }

}
extension MainViewController {
//  функция, проверяющая изменения в массиве Entity в EntityService
    func updateEntitiesOnTable() {
        viewModel.entitiesPublisher
            .sink { [weak self] entities in
                if let empty = self?.viewModel.entitiesAreEmptyArray() {
                    if empty {
                        self?.contentView.startGameLabelIsHidden(isHidden: false)
                    } else {
                        self?.contentView.startGameLabelIsHidden(isHidden: true)
                    }
                }
                self?.contentView.reloadData()
            }
            .store(in: &cancellables)
    }
//  функция, следящая за счетчиком deadStateEntityCount
    func checkDeadStateEntities() {
        viewModel.$deadStateEntityCount
            .receive(on: DispatchQueue.main)
            .sink { [weak self] count in
                if count > 2 {
                    self?.viewModel.killLivingEntityByDeadStateEntities()
                }
            }
            .store(in: &cancellables)
    }
//  функция, следящая за счетчиком aliveStateEntityCount
    func checkAliveStateEntities() {
        viewModel.$aliveStateEntityCount
            .receive(on: DispatchQueue.main)
            .sink { [weak self] count in
                if count > 2 {
                    self?.viewModel.createLivingEntity()
                }
            }
            .store(in: &cancellables)
    }
}
//  реализация функции делегата EntityCreationButtonMainViewDelegate
extension MainViewController: EntityCreationButtonMainViewDelegate {
    func entityCreationButtonDidPressed() {
        let lifeState = viewModel.getRandomEntityLifeState()
        viewModel.createNewEntity(with: lifeState)
    }
}
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.configureCell(tableView, cellForRowAt: indexPath)
    }
}

