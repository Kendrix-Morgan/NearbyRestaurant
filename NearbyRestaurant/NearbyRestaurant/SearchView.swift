//
//  SearchView.swift
//  NearbyRestaurant
//
//  Created by Kendrix on 2025/01/20.
//

import SwiftUI
import CoreLocation

struct SearchView: View {
    @State private var latitude: Double = 0.0
    @State private var longitude: Double = 0.0
    @State private var radius: Int = 1
    @State private var keyword: String = ""
    @State private var showResults = false

    var body: some View {
        NavigationView {
            VStack {
                Button("Get Current Location") {
                    getLocation()
                }
                .padding()

                TextField("ジャンルや料理名を入力 (例: 寿司、ピザ)", text: $keyword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Picker("Search Radius (km)", selection: $radius) {
                    ForEach(1...5, id: \.self) { distance in
                        Text("\(distance) km").tag(distance)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                NavigationLink(destination: ResultsView(latitude: latitude, longitude: longitude, radius: radius, keyword: keyword)) {
                    Text("Search")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
                .disabled(latitude == 0 && longitude == 0)
            }
            .padding()
            .navigationTitle("Restaurant Search")
        }
    }

    private func getLocation() {
        // Replace with actual CLLocationManager usage for GPS.
        latitude = 35.6895  // Example: Tokyo Latitude
        longitude = 139.6917 // Example: Tokyo Longitude
    }
}
#Preview {
    SearchView()
}
