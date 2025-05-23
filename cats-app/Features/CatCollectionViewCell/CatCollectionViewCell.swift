//
//  CatCollectionViewCell.swift
//  cats-app
//
//  Created by Edson Brandon on 23/05/25.
//

import UIKit

class CatCollectionViewCell: UICollectionViewCell {
    static let identifier = "CatCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var imageView = {
        let imageView = UIImageView()
        return imageView
    } ()
    
    func configure(with catId: String) {
        if let url = URL(string: "https://cataas.com/cat?id=" + catId) {
            imageView.load(url: url)
        }
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupView() {
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
        ])
    }
}
