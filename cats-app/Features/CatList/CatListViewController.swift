//
//  CatListViewController.swift
//  cats-app
//
//  Created by Edson Brandon on 22/05/25.
//

import UIKit

class CatListViewController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel = CatListViewModel()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.refreshControl = refreshControl
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.fetchInitialCats {
            self.reloadCollectionView()
        }
    }

    // MARK: - UI Setup
    
    private func setupView() {
        view.addSubview(collectionView)
        collectionView.register(CatCollectionViewCell.self, forCellWithReuseIdentifier: CatCollectionViewCell.identifier)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func createCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let itemsPerRow: CGFloat = 3
        let totalSpacing = spacing * (itemsPerRow - 1) + spacing * 2
        let itemWidth = (UIScreen.main.bounds.width - totalSpacing) / itemsPerRow
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        return layout
    }
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        return refreshControl
    } ()

    // MARK: - Data Handling
    
    @objc private func reloadData() {
        viewModel.fetchInitialCats {
            self.reloadCollectionView()
            self.refreshControl.endRefreshing()
        }
        
    }
    
    private func loadMoreItemsIfNeeded() {
        viewModel.loadMoreCats { indexPaths in
            self.collectionView.insertItems(at: indexPaths)
        }
    }

    func reloadCollectionView() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource

extension CatListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CatCollectionViewCell.identifier, for: indexPath) as? CatCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: viewModel.cats[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.width / 3
        return CGSize(width: size, height: size)
    }

    // MARK: - UIScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height * 1.5 {
            loadMoreItemsIfNeeded()
        }
    }
}
