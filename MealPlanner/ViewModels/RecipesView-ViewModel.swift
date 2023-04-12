//
//  ContentView-ViewModel.swift
//  MealPlanner
//
//  Created by Aymeric Pilaert on 11/04/2023.
//

import Foundation

    @MainActor class ViewModel: ObservableObject {
        
        @Published private(set) var allRecipes: [Meal]
        @Published var showAddMealSheet = false
        @Published private(set) var weekMeals: PlannedMeals
        
        let savedPathForRecipes = FileManager.documentsDirectory.appendingPathComponent("savedRecipes")
        let savedPathWeekMeals = FileManager.documentsDirectory.appendingPathComponent("savedWeekMeals")
        
        init() {
            do {
                let mealsListData = try Data(contentsOf: savedPathForRecipes)
                let weekMealsData = try Data(contentsOf: savedPathWeekMeals)
                allRecipes = try JSONDecoder().decode([Meal].self, from: mealsListData)
                weekMeals = try JSONDecoder().decode(PlannedMeals.self, from: weekMealsData)
            } catch {
                allRecipes = []
                weekMeals = PlannedMeals(planning: [:])
            }
        }
        
        func saveMealsList() {
            do {
                let data = try JSONEncoder().encode(allRecipes)
                try data.write(to: savedPathForRecipes)
            } catch {
                print("Cannot save to meals list")
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
        
        func addNewMeal(_ recipe: Meal) {
            allRecipes.append(recipe)
            saveMealsList()
        }
        
        
        
        
    }
