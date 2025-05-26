import UIKit

class CatCollectionViewCell: UICollectionViewCell {
    static let identifier = "CatCollectionViewCell"
    
    private var currentCatId: String?
    
    private lazy var catName: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    } ()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        currentCatId = nil
        activityIndicator.stopAnimating()
    }
    
    func configure(with cat: Cat) {
        currentCatId = cat.id
        catName.text = cat.tags.first ?? "Cat"
        imageView.image = nil
        
        guard let url = URL(string: "https://cataas.com/cat?id=" + cat.id) else {
            return
        }
        
        activityIndicator.startAnimating()
        NetworkManager.shared.fetchImage(with: url.absoluteString) { [weak self] image in
            DispatchQueue.main.async {
                guard let self = self else { return }

                if self.currentCatId == cat.id {
                    self.imageView.image = image
                }

                self.activityIndicator.stopAnimating()
            }
        }
    }
    
   
    
    private func setupView() {
        contentView.addSubview(imageView)
        contentView.addSubview(activityIndicator)
        contentView.addSubview(catName)
        
        NSLayoutConstraint.activate([
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: catName.topAnchor),
            
            catName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            catName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
