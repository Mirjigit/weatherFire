//
//  NetworkManager.swift
//  weatherAPP
//
//  Created by Миржигит Суранбаев on 23/10/23.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func fetchData(city: String,completion: @escaping (Result<Welcome,Error>) -> Void) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?appid=adcc3db81453c196edf0dc4af2859460&units=metric&q=\(city)") else {
            print("url nil")
            return
        }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let data = data else {
                print("data nil")
                return
            }
            do {
                let model = try JSONDecoder().decode(Welcome.self, from: data)
                completion(.success(model))
            } catch {
                completion(.failure(error))
            }
        }.resume()
        
    }
    
}
