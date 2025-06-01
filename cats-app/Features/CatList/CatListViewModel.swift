//
//  CatListViewModel.swift
//  cats-app
//
//  Created by Edson Brandon on 26/05/25.
//

import Foundation

protocol CatlistViewModelDelegate: NSObject {
    
}

class CatListViewModel {
    private(set) var cats: [Cat] = []
    private(set) var isLoading: Bool = false
    private var skip = 0
    private var limit = 20
    var onCatSelected: ((Cat) -> Void)?

    
    weak var delegate: CatlistViewModelDelegate?
    
    func fetchInitialCats(completion: @escaping () -> Void) {
        skip = 0
        NetworkManager.shared.getCats(skip: skip, limit: limit) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let catsResponse):
                    self.cats = catsResponse
                    self.skip += catsResponse.count
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
        
        NetworkManager.shared.getCats(skip: skip, limit: limit) { [weak self] result in
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
                    self.skip += newCats.count
                    let indexPaths = (startIndex..<self.cats.count).map { IndexPath(item: $0, section: 0) }
                    self.isLoading = false
                    completion(indexPaths)
                    
                case .failure(let error):
                    print("Erro ao buscar mais cats: \(error)")
                    self.isLoading = false
                    completion([])
                }
            }
        }
    }
    
    func resetCats() {
        cats = []
        skip = 0
    }
    
    func didSelectCat(cat: Cat) {
        onCatSelected?(cat)
    }
}
