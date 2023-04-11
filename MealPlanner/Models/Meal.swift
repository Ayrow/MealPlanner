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
    
    static let example = Meal(id: UUID(), name: "Porc au caramel", recipe: URL(string:  "https://www.marmiton.org/recettes/recette_porc-caramel_72335.aspx"))
}
