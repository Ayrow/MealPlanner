//
//  Meal.swift
//  MealPlanner
//
//  Created by Aymeric Pilaert on 11/04/2023.
//

import Foundation

struct Dish: Identifiable, Codable, Comparable, Equatable, Hashable {
    var id = UUID()
    var name: String
    var ingredients: [Ingredient?]
    var recipe: String?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ingredients)
    }
    
    static let emptySelection = Dish(id: UUID(), name: "Pick a Dish", ingredients: [Ingredient(name: "Pates", category: .Fruits)])
    
    static let example = Dish(id: UUID(), name: "Pâtes bolognaises", ingredients: [], recipe: "https://www.marmiton.org/recettes/recette_pates-a-la-bolognaise-facile_20482.aspx")
    
    static func <(lhs: Dish, rhs: Dish) -> Bool {
        lhs.name < rhs.name
    }
    
    static func ==(lhs: Dish, rhs: Dish) -> Bool {
        lhs.id == rhs.id
    }
}

struct MealsPlan: Codable, Equatable {
    
    enum DaysOfWeek: String, Codable, CaseIterable {
        case Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday
    }
    
    enum Mealtime: String, Codable, CaseIterable {
        case Lunch, Dinner
    }
    
    private var plannedMeals: [DaysOfWeek: [Mealtime: Dish?]]
    
    subscript(day: DaysOfWeek, mealType: Mealtime) -> Dish? {
        get { plannedMeals[day]?[mealType] ?? nil }
        set { plannedMeals[day]?[mealType] = newValue }
    }
    
    init() {
        plannedMeals = [:]
        for day in DaysOfWeek.allCases {
            plannedMeals[day] = [Mealtime: Dish?]()
            for mealType in Mealtime.allCases {
                plannedMeals[day]![mealType] = nil
            }
        }
    }
    
    mutating func reset() {
        plannedMeals = [:]
        for day in DaysOfWeek.allCases {
            plannedMeals[day] = [Mealtime: Dish?]()
            for mealType in Mealtime.allCases {
                plannedMeals[day]![mealType] = nil
            }
        }
    }

    
}
