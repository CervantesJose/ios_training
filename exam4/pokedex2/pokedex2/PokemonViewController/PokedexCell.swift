//
//  PokedexCell.swift
//  pokedex2
//
//  Created by Consultant on 6/23/22.
//

import UIKit

final class PokedexCell: UICollectionViewCell, ConfigurableCell {
    
    // MARK: Private properties
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 0.0
        return imageView
    }()
    
    private lazy var indexLabel: UILabel = {
        let label = UILabel(useAutolayout: true)
        label.textAlignment = .right
        label.textColor = .white
        label.alpha = 0.0
        return label
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel(useAutolayout: true)
        label.textAlignment = .center
        label.textColor = .white
        label.alpha = 0.0
        return label
    }()

    // MARK: - Public properties
    override var isHighlighted: Bool { didSet { animateHighlight(isHighlighted) }}

    var data: PokemonDetails?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .darkGray

        contentView.addSubview(imageView)
        imageView.pinToSuperview(with: UIEdgeInsets(top: 0, left: 0, bottom: 35, right: 0), edges: .all)
        
        contentView.addSubview(indexLabel)
        NSLayoutConstraint.activate([
            indexLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0),
            indexLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10.0)
        ])

        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15.0)
        ])
        
        layer.cornerRadius = 20.0
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
    }
    
    // MARK: - Public functions
    func configure(with pokemon: PokemonDetails) {
        data = pokemon
        
        titleLabel.text = pokemon.name.capitalized
        indexLabel.text = "#\(pokemon.id)"
        
        UIImage.load(from: pokemon.sprite.url) { [weak self] image in
            let color = image?.dominantColor ?? .darkGray
            
            DispatchQueue.main.async {
                self?.titleLabel.textColor = color.isLight ? .black : .white
                self?.indexLabel.textColor = color.isLight ? .black : .white
                self?.imageView.image = image
                self?.backgroundColor = color
                
                guard self?.imageView.alpha != 1.0 else { return }
                
                UIView.animate(withDuration: 0.2) {
                    self?.imageView.alpha = 1.0
                    self?.indexLabel.alpha = 1.0
                    self?.titleLabel.alpha = 1.0
                }
            }
        }
    }
    
    // MARK: - Private functions
    func animateHighlight(_ isHighlighted: Bool) {
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .allowUserInteraction, animations: {
            let scale: CGFloat = 0.95
            self.transform = isHighlighted ? CGAffineTransform(scaleX: scale, y: scale) : .identity
        }, completion: nil)
    }
}
