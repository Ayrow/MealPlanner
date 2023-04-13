//
//  Ingredients.swift
//  MealPlanner
//
//  Created by Aymeric Pilaert on 13/04/2023.
//

import Foundation

struct Ingredient: Identifiable, Codable, Equatable, Comparable, Hashable {
    var id = UUID()
    var name: String
    var category: Categories
    
    init(id: UUID = UUID(), name: String, category: Categories) {
        self.id = id
        self.name = name
        self.category = category
    }
    
    static let example = Ingredient(name: "Poivron", category: .Veggies)
    
    enum Categories: String, CaseIterable, Codable {
        case PastaRicePulses = "Pasta, Rice and Pulses"
        case GrainNutsBakingProducts = "Grain, Nuts and Baking Products"
        case EggsMilkProducts = "Eggs, Milk and Milk Products"
        case MeatAndFish = "Meat and Fish"
        case Veggies = "Vegetables"
        case Fruits = "Fruits"
        case HerbsAndSpices = "Herbs and Spices"
        case FatsOil = "Fats and Oils"
        case Others = "Others"
    }
    
    enum CodingKeys: CodingKey {
        case name, category, id
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.category = try container.decode(Categories.self, forKey: .category)
        self.id = try container.decode(UUID.self, forKey: .id)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(category, forKey: .category)
        try container.encode(id, forKey: .id)
    }
    
    static func ==(lhs: Ingredient, rhs: Ingredient) -> Bool {
        lhs.id == rhs.id
    }
    
    static func <(lhs: Ingredient, rhs: Ingredient) -> Bool {
        lhs.name < rhs.name
    }
    
   
    
}
