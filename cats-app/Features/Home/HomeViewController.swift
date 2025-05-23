//
//  HomeViewController.swift
//  cats-app
//
//  Created by Edson Brandon on 22/05/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    var cats: [Cat] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(CatCollectionViewCell.self, forCellWithReuseIdentifier: CatCollectionViewCell.identifier)
        setupView()
        fetchCats()
    }
    
    
    private lazy var collectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let spacing: CGFloat = 8
        let itemsPerRow: CGFloat = 3
        let totalSpacing = spacing * (itemsPerRow - 1) + spacing * 2
        
        let itemWidth = (UIScreen.main.bounds.width - totalSpacing) / itemsPerRow
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    } ()
    
    func reloadCollectionView() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    private func fetchCats() {
        NetworkManager.shared.getCats { result in
            switch result {
            case .success(let catsResponse):
                self.cats = catsResponse
                DispatchQueue.main.async{
                    self.collectionView.reloadData()
                }
                
                print("Cats recebidos: \(self.cats)")
                
            case .failure(let error):
                print("Erro ao buscar cats: \(error)")
            }
        }
    }
    
    private func setupView() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CatCollectionViewCell.identifier, for: indexPath) as! CatCollectionViewCell
        cell.configure(with: cats[indexPath.row].id)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.width / 3
            return CGSize(width: size, height: size)
        }
}
