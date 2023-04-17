//
//  MainView-ViewModel.swift
//  MealPlanner
//
//  Created by Aymeric Pilaert on 12/04/2023.
//

import SwiftUI

@MainActor class MainViewViewModel: ObservableObject {
    @Published var weekMeals = MealsPlan()
    
    let savedPathWeekMeals = FileManager.documentsDirectory.appendingPathComponent("savedWeekMeals")
    
    init() {
        do {
            let weekMealsData = try Data(contentsOf: savedPathWeekMeals)
            weekMeals = try JSONDecoder().decode(MealsPlan.self, from: weekMealsData)
        } catch {
            weekMeals.reset()
        }
        
    }
    
    func saveWeekMeals() {
        do {
            let data = try JSONEncoder().encode(weekMeals)
            try data.write(to: savedPathWeekMeals)
        } catch {
            print("Unable to save the meals for the week: \(error.localizedDescription)")
        }
    }
    
    func checkIfNoMealPlanned() -> Bool {
        for day in MealsPlan.DaysOfWeek.allCases {
            for mealtime in MealsPlan.Mealtime.allCases {
                if weekMeals[day, mealtime] != nil {
                    return false
                }
            }
        }
        return true
    }
    
}
