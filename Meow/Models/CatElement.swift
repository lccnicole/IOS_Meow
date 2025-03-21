//
//  CatElement.swift
//  Meow
//
//  Created by Leong, Choi Chee on 4/2/21.
//
import Foundation
import RealmSwift

// MARK: - CatElement
public class CatElement: Object, Decodable {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var adoptedAt: Date?
    @objc dynamic var url: String

    public let breeds: [Breed]?
    public let categories: [Category]?
    public let height: Int?
    public let width: Int?
    
    public override static func primaryKey() -> String? {
        return "id"
    }
}

// MARK: - Category
public struct Category: Decodable {
    let id: Int?
    let name: String?
}

// MARK: - Breed
public struct Breed: Decodable {
    public let adaptability, affectionLevel: Int?
    public let altNames: String?
    public let childFriendly: Int?
    public let countryCode, countryCodes, breedDescription: String?
    public let dogFriendly, energyLevel, experimental, grooming: Int?
    public let hairless, healthIssues, hypoallergenic: Int?
    public let id: String?
    public let indoor, intelligence, lap: Int?
    public let lifeSpan, name: String?
    public let natural: Int?
    public let origin: String?
    public let rare: Int?
    public let referenceImageID: String?
    public let rex, sheddingLevel, shortLegs, socialNeeds: Int?
    public let strangerFriendly, suppressedTail: Int?
    public let temperament: String?
    public let vetstreetURL: String?
    public let vocalisation: Int?
    public let weight: Weight?
    public let wikipediaURL: String?

    private enum CodingKeys: String, CodingKey {
        case adaptability
        case affectionLevel = "affection_level"
        case altNames = "alt_names"
        case childFriendly = "child_friendly"
        case countryCode = "country_code"
        case countryCodes = "country_codes"
        case breedDescription = "description"
        case dogFriendly = "dog_friendly"
        case energyLevel = "energy_level"
        case experimental, grooming, hairless
        case healthIssues = "health_issues"
        case hypoallergenic, id, indoor, intelligence, lap
        case lifeSpan = "life_span"
        case name, natural, origin, rare
        case referenceImageID = "reference_image_id"
        case rex
        case sheddingLevel = "shedding_level"
        case shortLegs = "short_legs"
        case socialNeeds = "social_needs"
        case strangerFriendly = "stranger_friendly"
        case suppressedTail = "suppressed_tail"
        case temperament
        case vetstreetURL = "vetstreet_url"
        case vocalisation, weight
        case wikipediaURL = "wikipedia_url"
    }
}

// MARK: - Weight
public struct Weight: Codable {
    let imperial, metric: String?
}



