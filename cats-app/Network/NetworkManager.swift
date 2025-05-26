//
//  NetworkManager.swift
//  cats-app
//
//  Created by Edson Brandon on 22/05/25.
//

import Foundation
import UIKit
class NetworkManager {
    static let shared           = NetworkManager()
    private let baseURL         = "https://cataas.com/"
    let cache                   = NSCache<NSString, UIImage>()
    private init() {}
    
    func getCats(skip: Int, limit: Int, completion: @escaping (Result<[Cat], CatError>) -> Void) {
        let endpoint = baseURL + "api/cats?limit=\(limit)&skip=\(skip)"
        
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
    
    func fetchImage(with urlString: String, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = cache.object(forKey: urlString as NSString) {
            completion(cachedImage)
            return
        }

        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            var image: UIImage? = nil
            if let data = data {
                image = UIImage(data: data)
                if let img = image {
                    self.cache.setObject(img, forKey: urlString as NSString)
                }
            }
            completion(image)
        }.resume()
    }

}
