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
        populateStackView()
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
    
    private lazy var idLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .systemGray
        label.text = "ID: " + viewModel.cat.id
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()

    private lazy var tagsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .systemGray
        label.text = "Tags:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    private lazy var tagsStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = 16
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    } ()
    
    private lazy var createdAtLabel: UILabel = {
        let label = UILabel()
        
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        inputDateFormatter.locale = Locale(identifier: "en_US_POSIX")
        inputDateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateStyle = .medium
        outputDateFormatter.timeStyle = .short
        outputDateFormatter.locale = Locale(identifier: "en_US")
        outputDateFormatter.doesRelativeDateFormatting = true
        
        if let dateObject = inputDateFormatter.date(from: viewModel.cat.createdAt) {
            label.text = "Created At: " + outputDateFormatter.string(from: dateObject)
        } else {
            label.text = "Created At: Invalid Date"
        }
        
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    private func populateStackView() {
        if viewModel.cat.tags.isEmpty {
            tagsLabel.isHidden = true
        }
        
        for tagText in viewModel.cat.tags {
            let tagLabel = TagLabel()
            tagLabel.text = tagText
            
            tagsStackView.addArrangedSubview(tagLabel)
        }
    }
    
    private func setupView() {
        view.addSubview(catBanner)
        view.addSubview(tagsStackView)
        view.addSubview(idLabel)
        view.addSubview(tagsLabel)
        view.addSubview(createdAtLabel)
        
        view.backgroundColor = .systemBackground
    }
    
    private func setupConstraints() {
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            catBanner.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            catBanner.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            catBanner.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            catBanner.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            
            idLabel.topAnchor.constraint(equalTo: catBanner.bottomAnchor, constant: padding),
            idLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            
            tagsLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: padding),
            tagsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            
            tagsStackView.topAnchor.constraint(equalTo: tagsLabel.bottomAnchor, constant: padding),
            tagsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            
            createdAtLabel.topAnchor.constraint(equalTo: tagsStackView.bottomAnchor, constant: padding),
            createdAtLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
        ])
    }
}
