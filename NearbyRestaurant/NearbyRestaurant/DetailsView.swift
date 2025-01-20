//
//  DetailsView.swift
//  NearbyRestaurant
//
//  Created by Kendrix on 2025/01/20.
//

import SwiftUI

struct DetailsView: View {
    let restaurant: Restaurant

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: URL(string: restaurant.imageURL)) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 200)
                        .cornerRadius(12)
                } placeholder: {
                    ProgressView()
                }

                Text(restaurant.name).font(.largeTitle).bold()
                Text("Address: \(restaurant.address)").font(.body)
                Text("Business Hours: \(restaurant.businessHours)").font(.body)
                Spacer()

                Button("Open in Maps") {
                    openInMaps()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
        }
        .navigationTitle("Details")
    }

    private func openInMaps() {
        let url = "maps://?q=\(restaurant.name)&sll=\(restaurant.address)"
        if let encoded = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let mapURL = URL(string: encoded) {
            UIApplication.shared.open(mapURL)
        }
    }
}
