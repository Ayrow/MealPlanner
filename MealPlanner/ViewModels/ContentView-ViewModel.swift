//
//  ContentView-ViewModel.swift
//  MealPlanner
//
//  Created by Aymeric Pilaert on 11/04/2023.
//

import Foundation

extension ContentView {
    @MainActor class ViewModel {
        
        @Published private(set) var possibleMeals: [Meal]
        
        let savedPathForMeals = FileManager.documentsDirectory.appendingPathComponent("savedMeals")
        
        init() {
            do {
                let mealsData = try Data(contentsOf: savedPathForMeals)
                possibleMeals = try JSONDecoder().decode([Meal].self, from: mealsData)
                
            } catch {
                possibleMeals = []
            }
        }
        
        
        
    }
}
