//
//  DetailCell.swift
//  pokedex2
//
//  Created by Consultant on 6/23/22.
//

import UIKit

struct DetailItem {
    let title: String
    let value: String
}

// MARK: -
final class DetailCell: UITableViewCell, ConfigurableCell {

    // MARK: Private properties
    private lazy var titleLabel: UILabel = {
        let label = UILabel(useAutolayout: true)
        label.textColor = .gray
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel(useAutolayout: true)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Public properties
    var data: DetailItem?
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15.0),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15.0),
            titleLabel.widthAnchor.constraint(equalToConstant: 140.0)
        ])
        
        contentView.addSubview(valueLabel)
        NSLayoutConstraint.activate([
            valueLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 15.0),
            valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15.0),
            valueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15.0),
            valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15.0)
        ])
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - Public functions
    func configure(with item: DetailItem) {
        self.data = item
        
        titleLabel.text = item.title
        valueLabel.text = item.value
        selectionStyle = .none
    }
}
