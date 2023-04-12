//
//  ContentView-ViewModel.swift
//  MealPlanner
//
//  Created by Aymeric Pilaert on 11/04/2023.
//

import Foundation

    @MainActor class ViewModel: ObservableObject {
        
        @Published private(set) var possibleMealsList: [Meal]
        @Published var showAddMealSheet = false
        
        let savedPathForAllMeals = FileManager.documentsDirectory.appendingPathComponent("savedMeals")
        
        init() {
            do {
                let mealsListData = try Data(contentsOf: savedPathForAllMeals)
                possibleMealsList = try JSONDecoder().decode([Meal].self, from: mealsListData)
                
            } catch {
                possibleMealsList = []
            }
        }
        
        func saveMealsList() {
            do {
                let data = try JSONEncoder().encode(possibleMealsList)
                try data.write(to: savedPathForAllMeals)
            } catch {
                print("Cannot save to meals list")
            }
        }
        
        func addNewMeal(_ newMeal: Meal) {
            possibleMealsList.append(newMeal)
            saveMealsList()
        }
        
        
        
        
    }
