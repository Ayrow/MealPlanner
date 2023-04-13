//
//  Ingredients.swift
//  MealPlanner
//
//  Created by Aymeric Pilaert on 13/04/2023.
//

import Foundation

struct Ingredient: Identifiable, Codable, Equatable, Comparable {
    var id = UUID()
    var name: String
    var category: Categories
    
    enum Categories: String, CaseIterable, Codable {
        case EggsMilkProducts = "Eggs, Milk and Milk Products"
        case FatsOil = "Fats and Oils"
        case Fruits
        case GrainNutsBakingProducts = "Grain, Nuts and Baking Products"
        case HerbsAndSpices = "Herbs and Spices"
        case MeatAndFish = "Meat and Fish"
        case PastaRicePulses = "Pasta, Rice and Pulses"
        case Veggies = "Vegetables"
        case Others
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
