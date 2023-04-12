//
//  Meal.swift
//  MealPlanner
//
//  Created by Aymeric Pilaert on 11/04/2023.
//

import Foundation

struct Meal: Identifiable, Comparable, Codable, Hashable {
    let id: UUID
    var name: String
    var ingredients: [String]?
    var recipe: URL?
    
    static let emptySelection = Meal(id: UUID(), name: "Pick a Meal")
    
    static let example = Meal(id: UUID(), name: "Pâtes bolognaises", ingredients: ["pâtes", "sauce tomates", "oignons", "carottes", "viande hachée"], recipe: URL(string:  "https://www.marmiton.org/recettes/recette_pates-a-la-bolognaise-facile_20482.aspx"))
    
    static func <(lhs: Meal, rhs: Meal) -> Bool {
        lhs.name < rhs.name
    }
}

struct MealsPlan: Codable, Hashable {
    
    enum DaysOfWeek: String, Codable, CaseIterable {
        case monday, tuesday, wednesday, thursday, friday, saturday, sunday
    }
    
    enum MealType: String, Codable, CaseIterable {
        case lunch, dinner
    }
    
    private var plannedMeals: [DaysOfWeek: [MealType: Meal?]]
    
    subscript(day: DaysOfWeek, mealType: MealType) -> Meal? {
        get { plannedMeals[day]?[mealType] ?? nil }
        set { plannedMeals[day]?[mealType] = newValue }
    }
    
    init() {
        plannedMeals = [:]
        for day in DaysOfWeek.allCases {
            plannedMeals[day] = [MealType: Meal?]()
            for mealType in MealType.allCases {
                plannedMeals[day]![mealType] = nil
            }
        }
    }
    
    mutating func reset() {
        plannedMeals = [:]
        for day in DaysOfWeek.allCases {
            plannedMeals[day] = [MealType: Meal?]()
            for mealType in MealType.allCases {
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
