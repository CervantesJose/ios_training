//
//  PokedexViewController.swift
//  pokedex2
//
//  Created by Consultant on 6/23/22.
//


import UIKit

final class PokedexViewController: CollectionViewController {
    
    // MARK: Private properties
    private let interactor: PokedexInteractable
    private let viewModel: ViewModel

    // MARK: - Public properties
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    
    // MARK: - Init
    init(interactor: PokedexInteractable, viewModel: ViewModel = ViewModel()) {
        self.interactor = interactor
        self.viewModel = viewModel
        super.init(layout: UICollectionViewFlowLayout.pokedexLayout)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.title
        
        collectionView.backgroundColor = .darkGrey
        navigationItem.backButtonTitle = ""
        
        requestData()
    }
    
    // MARK: - Private functions
    private func requestData() {
        startSpinner()
        
        viewModel.requestData { [weak self] result in
            self?.spinner.stopAnimating()
            
            switch result {
            case let .success(dataSource): self?.collectionData = dataSource
            case let .failure(error): print(error.localizedDescription)
            }
        }
    }
    
    private func startSpinner() {
        collectionView.backgroundView = collectionData.hasData ? nil : spinner
        spinner.startAnimating()
    }
    
    // MARK: - Collection View Delegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        interactor.selectPokemon(at: indexPath, in: collectionView)
    }
}

// MARK: - Collection View Layout
extension PokedexViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .cellSize(from: collectionView)
    }
}

// MARK: - Scroll View Delegate
extension PokedexViewController {
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.hasScrolledToBottom else { return }
        
        spinner.startAnimating()
        requestData()
    }
}
