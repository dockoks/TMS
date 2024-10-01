//
//  NetworkManager.swift
//  HW29App
//
//  Created by Danila Kokin on 21/9/24.
//


import Foundation

enum NetworkError: Error {
    case invalidURL
    case failedLoadingData
    case failedToSerialise
}

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func fetchUsers(completion: @escaping (Result<[UserDTO], NetworkError>) -> Void) {
        let urlString = "https://jsonplaceholder.typicode.com/users"
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.failedLoadingData))
                return
            }
            
            do {
                let users = try JSONDecoder().decode([UserDTO].self, from: data)
                completion(.success(users))
            } catch {
                completion(.failure(.failedToSerialise))
            }
        }
        task.resume()
    }
}
