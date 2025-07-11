//
//  UiImage+Ext.swift
//  cats-app
//
//  Created by Edson Brandon on 23/05/25.
//

import Foundation
import UIKit



extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
