//
//  Meal.swift
//  MealPlanner
//
//  Created by Aymeric Pilaert on 11/04/2023.
//

import Foundation

struct Meal: Identifiable, Codable {
    let id: UUID
    var name: String
    var ingredients: [String]?
    var recipe: URL?
    
    static let example = Meal(id: UUID(), name: "Pâtes bolognaises", ingredients: ["pâtes", "sauce tomates", "oignons", "carottes", "viande hachée"], recipe: URL(string:  "https://www.marmiton.org/recettes/recette_pates-a-la-bolognaise-facile_20482.aspx"))
}


// Un jour > Un moment (lunch ou dinner) > Meal
