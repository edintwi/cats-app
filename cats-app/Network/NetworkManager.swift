//
//  NetworkManager.swift
//  cats-app
//
//  Created by Edson Brandon on 22/05/25.
//

import Foundation

class NetworkManager {
    static let shared           = NetworkManager()
    private let baseURL         = "https://cataas.com/"
    
    private init() {}
    
    func getCats(completion: @escaping (Result<[Cat], CatError>) -> Void) {
        let endpoint = baseURL + "api/cats?limit=10"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let cats = try decoder.decode([Cat].self, from: data)
                completion(.success(cats))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
}
