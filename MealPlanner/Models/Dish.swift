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
    
    static let emptySelection = Dish(id: UUID(), name: "Pick a Meal", ingredients: [Ingredient(name: "Pates", category: .Fruits)])
    
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


/*
struct MealsPlan: Codable {
    
    enum DaysOfWeek: Codable, CaseIterable {
        case monday, tuesday, wednesday, thursday, friday, saturday, sunday
    }
    
    enum MealType: Codable, CaseIterable {
        case lunch, dinner
    }
    
    var day: DaysOfWeek
    var mealType: MealType
    var meal: Meal
    
    init(day: DaysOfWeek, mealType: MealType, meal: Meal, p) {
        self.day = day
        self.mealType = mealType
        self.meal = meal
        self.pla
    }
    
    static let example = MealsPlan(day: .monday, mealType: .lunch, meal: Meal(id: UUID(), name: "Pâtes bolo"))
    
    enum CodingKeys: CodingKey {
        case day, mealType, meal
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.day = try container.decode(DaysOfWeek.self, forKey: .day)
        self.mealType = try container.decode(MealType.self, forKey: .mealType)
        self.meal = try container.decode(Meal.self, forKey: .meal)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(day, forKey: .day)
        try container.encode(mealType, forKey: .mealType)
        try container.encode(meal, forKey: .meal)
    }
    
}


  */
