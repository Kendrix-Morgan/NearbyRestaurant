//
//  ResultsView.swift
//  NearbyRestaurant
//
//  Created by Kendrix on 2025/01/20.
//

import SwiftUI

struct ResultsView: View {
    let latitude: Double
    let longitude: Double
    let radius: Int
    let keyword: String?

    @State private var restaurants: [Restaurant] = []
    @State private var isLoading = true
    @State private var errorMessage: String?

    var body: some View {
        VStack {
            if isLoading {
                ProgressView("Loading Restaurants...")
            } else if let errorMessage = errorMessage {
                Text("Error: \(errorMessage)")
            } else {
                List(restaurants) { restaurant in
                    NavigationLink(destination: DetailsView(restaurant: restaurant)) {
                        HStack {
                            AsyncImage(url: URL(string: restaurant.imageURL)) { image in
                                image.resizable()
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(8)
                            } placeholder: {
                                ProgressView()
                            }
                            VStack(alignment: .leading) {
                                Text(restaurant.name).font(.headline)
                                Text(restaurant.access).font(.subheadline).foregroundColor(.gray)
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            fetchRestaurants()
        }
        .navigationTitle("Results")
    }

    private func fetchRestaurants() {
        ApiClient.shared.fetchRestaurants(latitude: latitude, longitude: longitude, radius: radius, keyword: keyword) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    restaurants = data
                    isLoading = false
                case .failure(let error):
                    errorMessage = error.localizedDescription
                    isLoading = false
                }
            }
        }
    }
}

