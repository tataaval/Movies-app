//
//  NetworkService.swift
//  Movies-app
//
//  Created by Tatarella on 02.07.24.
//

import Foundation

class NetworkService {
    
    static let shared = NetworkService()
    
    private let headers: [String: String] = [
        "accept": "application/json",
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5MTAxMjYzMDJmNTFkYjc5ZjQ4NTY2ZWNmZGRjNjZkMCIsIm5iZiI6MTcxOTkyMjAyNi4zNzgxMywic3ViIjoiNjY4MjY3ZTNmYjAxYTZkNGZlMTc4MTcwIiwic2NvcGVzIjpbImFwaV9yZWFkIl0sInZlcnNpb24iOjF9.3NbzZ9tXR3LLQBNe_YgQ7pktibh8lxIlHDnehS3oaoc"
    ]
    
    func getData<T: Codable>(baseURL: String, path: String, queryItems: [URLQueryItem]? = nil, completion: @escaping (Result<T,Error>) -> (Void)) {
        
        guard var components = URLComponents(string: baseURL) else {
            print("Invalid url")
            return
        }
        
        components.path = path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            print("Invalid url")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("wrong Response")
                return
            }
            
            guard (200...299).contains(response.statusCode) else {
                print("wrong Response code")
                return
            }
            
            guard let data = data else {
                print("დატა არალი!")
                return
            }
            
            do {
                
                let decoder = JSONDecoder()
                let object = try decoder.decode(T.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(object))
                }
                
            } catch {
                print(error.localizedDescription)
                completion(.failure(error))
            }
            
        }.resume()
    }
}
