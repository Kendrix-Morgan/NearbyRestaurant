//
//  ApiClient.swift
//  NearbyRestaurant
//
//  Created by Kendrix on 2025/01/20.
//

import Foundation

class ApiClient {
    static let shared = ApiClient()
    private let apiKey = "50cefeb9246c3c52"

    // Fetch restaurants based on location and search parameters
    func fetchRestaurants(latitude: Double, longitude: Double, radius: Int, keyword: String?, completion: @escaping (Result<[Restaurant], Error>) -> Void) {
        var urlString = "https://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=\(apiKey)&lat=\(latitude)&lng=\(longitude)&range=\(radius)&format=json"
        
        // Add keyword parameter if it's not empty
        if let keyword = keyword, !keyword.isEmpty {
            urlString += "&keyword=\(keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
        }
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let apiResponse = try JSONDecoder().decode(ApiResponse.self, from: data)
                completion(.success(apiResponse.results.shops))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
