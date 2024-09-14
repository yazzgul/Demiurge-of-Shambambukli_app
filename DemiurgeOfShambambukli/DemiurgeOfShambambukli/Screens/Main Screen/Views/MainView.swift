//
//  MainView.swift
//  DemiurgeOfShambambukli
//
//  Created by Язгуль Хасаншина on 14.09.2024.
//

import UIKit

protocol EntityCreationButtonMainViewDelegate: AnyObject {
    func entityCreationButtonDidPressed()
}

class MainView: UIView {

    private lazy var gameNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Клеточное наполнение"
        label.numberOfLines = .zero
        label.font = .systemFont(ofSize: 24, weight: .heavy, width: .condensed)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var gameTableView: UITableView = {
        let table = UITableView()
        table.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.reuseIdentifier)
        table.backgroundColor = .white
        table.rowHeight = 100
        table.showsVerticalScrollIndicator = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    private lazy var entityCreationButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Сотворить", for: .normal)
        button.setTitleColor(.purple, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true

        let action = UIAction { [weak self] _ in
            self?.entityCreationButtonDelegate?.entityCreationButtonDidPressed()
        }

        button.addAction(action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    weak var entityCreationButtonDelegate: EntityCreationButtonMainViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .purple

        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension MainView {
    private func configureView() {
        addSubview(gameNameLabel)
        addSubview(gameTableView)
        addSubview(entityCreationButton)

        NSLayoutConstraint.activate([

            //  установка constraint для надписи "Клеточное наполнение" gameNameLabel
            gameNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 4),
            gameNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            gameNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 64),
            gameNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -64),
            gameNameLabel.heightAnchor.constraint(equalToConstant: 24.0),

            //  установка constraint для кнопки создания сущностей entityCreationButton
            entityCreationButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -24),
            entityCreationButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            entityCreationButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 24),
            entityCreationButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -24),
            entityCreationButton.heightAnchor.constraint(equalToConstant: 32.0),

            //  установка constraint для таблицы игры gameTableView
            gameTableView.topAnchor.constraint(equalTo: gameNameLabel.bottomAnchor, constant: 24),
            gameTableView.centerXAnchor.constraint(equalTo: centerXAnchor),
            gameTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 24),
            gameTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -24),
            gameTableView.bottomAnchor.constraint(equalTo: entityCreationButton.topAnchor, constant: -24),

        ])
    }

}
// Функции таблицы
extension MainView {
    func setupDataSource(_ dataSource: UITableViewDataSource) {
        gameTableView.dataSource = dataSource
    }
    func setupDelegate(_ delegate: UITableViewDelegate) {
        gameTableView.delegate = delegate
    }
    func reloadData() {
        gameTableView.reloadData()
    }
}
