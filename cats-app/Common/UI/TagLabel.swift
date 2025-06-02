//
//  TagLabel.swift
//  cats-app
//
//  Created by Edson Brandon on 02/06/25.
//

import UIKit

class TagLabel: UILabel {
    var textInsets = UIEdgeInsets(top: 8, left: 4, bottom: 8, right: 4)
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLabel() {
        self.font = .systemFont(ofSize: 14)
        self.textColor = .systemBlue
        self.backgroundColor = .lightGray.withAlphaComponent(0.2)
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        self.textAlignment = .center
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize

        contentSize.width += textInsets.left + textInsets.right
        contentSize.height += textInsets.top + textInsets.bottom
    
        return contentSize
    }
}
