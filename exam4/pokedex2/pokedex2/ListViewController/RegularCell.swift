//
//  RegularCell.swift
//  pokedex2
//
//  Created by Consultant on 6/23/22.
//

import UIKit

struct ItemData {
    var title: String? = nil
    var items: [ItemDetails] = []
}

// MARK: -
final class RegularCell: UITableViewCell, ConfigurableCell {

    // MARK: Public properties
    var data: ItemData?
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        accessoryView = UILabel.accessoryView
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - Public functions
    func configure(with data: ItemData) {
        self.data = data
        
        textLabel?.text = data.title?.cleaned
        textLabel?.textColor = .white
    }
}
