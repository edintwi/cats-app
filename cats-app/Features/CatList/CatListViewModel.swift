//
//  CatListViewModel.swift
//  cats-app
//
//  Created by Edson Brandon on 26/05/25.
//

import Foundation

class CatListViewModel {
    private(set) var cats: [Cat] = []
    private(set) var isLoading: Bool = false
    
    func fetchCats(completion: @escaping () -> Void) {
        NetworkManager.shared.getCats { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let catsResponse):
                    self.cats = catsResponse
                    print("Cats recebidos: \(self.cats)")
                    
                case .failure(let error):
                    print("Erro ao buscar cats: \(error)")
                }
                completion()
            }
        }
    }
    
    func loadMoreCats(completion: @escaping ([IndexPath]) -> Void) {
        guard !isLoading else { return }
        isLoading = true
        
        NetworkManager.shared.getCats { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                switch result {
                case .success(let newCats):
                    guard !newCats.isEmpty else {
                        self.isLoading = false
                        completion([])
                        return
                    }
                    
                    let startIndex = self.cats.count
                    self.cats.append(contentsOf: newCats)
                    let indexPaths = (startIndex..<self.cats.count).map {
                        IndexPath(item: $0, section: 0)
                    }
                    self.isLoading = false
                    completion(indexPaths)
                    
                case .failure(let error):
                    print("Erro ao buscar cats: \(error)")
                    self.isLoading = false
                    completion([])
                }
            }
        }
    }
}
