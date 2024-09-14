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

    }

}
extension MainViewController {
    func updateEntitiesOnTable() {
        viewModel.entitiesPublisher
            .sink { [weak self] _ in
                self?.contentView.reloadData()
            }
            .store(in: &cancellables)
    }
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
}
extension MainViewController: EntityCreationButtonMainViewDelegate {
    func entityCreationButtonDidPressed() {
        let lifeState = viewModel.getRandomEntityLifeState()
        let entity = viewModel.createNewEntity(with: lifeState)
        
//        print("button did pressed, new entity: \(entity)")
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

