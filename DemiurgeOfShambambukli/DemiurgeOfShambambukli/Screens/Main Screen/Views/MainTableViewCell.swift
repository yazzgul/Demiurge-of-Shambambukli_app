//
//  MainTableViewCell.swift
//  DemiurgeOfShambambukli
//
//  Created by Язгуль Хасаншина on 14.09.2024.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    private lazy var entityImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 32
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private lazy var entityNameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = .zero
        label.font = .systemFont(ofSize: 20, weight: .heavy, width: .condensed)
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var entityDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = .zero
        label.font = .systemFont(ofSize: 16, weight: .medium, width: .condensed)
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = .white

        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override func prepareForReuse() {
        super.prepareForReuse()

        entityImageView.image = nil
    }

}
extension MainTableViewCell {
    private func configureView() {
        contentView.addSubview(entityImageView)
        contentView.addSubview(entityNameLabel)
        contentView.addSubview(entityDescriptionLabel)

        NSLayoutConstraint.activate([
            //  установка constraint для фото сущности entityImageView
            entityImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            entityImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            entityImageView.widthAnchor.constraint(equalToConstant: 64.0),
            entityImageView.heightAnchor.constraint(equalToConstant: 64.0),

            //  установка constraint для названия сущности entityNameLabel
            entityNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 28),
            entityNameLabel.leadingAnchor.constraint(equalTo: entityImageView.trailingAnchor, constant: 16),
            entityNameLabel.widthAnchor.constraint(equalToConstant: 100.0),
            entityNameLabel.heightAnchor.constraint(equalToConstant: 20.0),

            //  установка constraint для описания сущности entityDescriptionLabel
            entityDescriptionLabel.topAnchor.constraint(equalTo: entityNameLabel.bottomAnchor, constant: 8),
            entityDescriptionLabel.leadingAnchor.constraint(equalTo: entityImageView.trailingAnchor, constant: 16),
            entityDescriptionLabel.widthAnchor.constraint(equalToConstant: 200.0),
            entityDescriptionLabel.heightAnchor.constraint(equalToConstant: 20.0)
        ])
    }

}
extension MainTableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
extension MainTableViewCell {
    func configureCell(with image: UIImage) {
        entityImageView.image = image
    }
    func configureCell(with entity: Entity) {
        entityNameLabel.text = entity.name
        entityDescriptionLabel.text = entity.description
    }
}
