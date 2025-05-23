//
//  HomeViewController.swift
//  cats-app
//
//  Created by Edson Brandon on 22/05/25.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        NetworkManager.shared.getCats { result in
            switch result {
            case .success(let cats):
                print("Cats recebidos: \(cats)")
            case .failure(let error):
                print("Erro ao buscar cats: \(error)")
            }
        }
    }
}
