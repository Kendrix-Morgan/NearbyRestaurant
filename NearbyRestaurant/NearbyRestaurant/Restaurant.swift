//
//  Restaurant.swift
//  NearbyRestaurant
//
//  Created by Kendrix on 2025/01/20.
//

import Foundation

// Root response object
struct ApiResponse: Codable {
    let results: Results
}

struct Results: Codable {
    let shops: [Restaurant]

    enum CodingKeys: String, CodingKey {
        case shops = "shop"
    }
}

// Restaurant model (already created but expanded here)
struct Restaurant: Identifiable, Codable {
    let id: String
    let name: String
    let access: String
    let imageURL: String
    let address: String
    let businessHours: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case access
        case imageURL = "photo"
        case address
        case businessHours = "open"
    }

    enum PhotoKeys: String, CodingKey {
        case mobile
    }

    enum MobileKeys: String, CodingKey {
        case large = "l"
    }

    // Custom initializer for nested photo decoding
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        access = try container.decode(String.self, forKey: .access)
        address = try container.decode(String.self, forKey: .address)
        businessHours = try container.decode(String.self, forKey: .businessHours)

        // Decode nested image URL
        let photoContainer = try? container.nestedContainer(keyedBy: PhotoKeys.self, forKey: .imageURL)
        let mobileContainer = try? photoContainer?.nestedContainer(keyedBy: MobileKeys.self, forKey: .mobile)
        imageURL = try mobileContainer?.decode(String.self, forKey: .large) ?? ""
    }
}
