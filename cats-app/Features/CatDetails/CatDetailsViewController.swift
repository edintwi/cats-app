//
//  CatDetailsViewController.swift
//  cats-app
//
//  Created by Edson Brandon on 27/05/25.
//

import UIKit

class CatDetailsViewController: UIViewController {
    private let viewModel: CatDetailsViewModel
    
    init(viewModel: CatDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    private lazy var catBanner: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        if let url = URL(string: "https://cataas.com/cat/" + viewModel.cat.id) {
            imageView.load(url: url)
        } else {
            imageView.image = UIImage(systemName: "photo")
            imageView.backgroundColor = .lightGray
        }
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    } ()
    
    private func setupView() {
        view.addSubview(catBanner)
        view.backgroundColor = .systemBackground
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            catBanner.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            catBanner.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            catBanner.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            catBanner.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
        ])
    }
}
