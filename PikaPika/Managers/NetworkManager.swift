//
//  NetworkManager.swift
//  PikaPika
//
//  Created by Marius Stefanita Jianu on 28.04.2023.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case dataError
    case decodingError(Error)
}

class NetworkManager {
    
    func fetchData<T: Decodable>(urlString: String, completion: @escaping (Result<T, APIError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let session = URLSession.shared
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { data, response, error in
            if let _ = error {
                completion(.failure(.dataError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.dataError))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(T.self, from: data)
                completion(.success(jsonData))
            } catch let error {
                completion(.failure(.decodingError(error)))
            }
        }
        
        task.resume()
    }
}
