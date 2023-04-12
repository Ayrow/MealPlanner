//
//  ContentView-ViewModel.swift
//  MealPlanner
//
//  Created by Aymeric Pilaert on 11/04/2023.
//

import Foundation
import SwiftUI

    @MainActor class RecipesViewViewModel: ObservableObject {
        
        @Published private(set) var allRecipes: [Meal]
        
        @Published var showAddMealSheet = false
        
        let savedPathForRecipes = FileManager.documentsDirectory.appendingPathComponent("savedRecipes")
        
        init() {
            do {
                let mealsListData = try Data(contentsOf: savedPathForRecipes)
                allRecipes = try JSONDecoder().decode([Meal].self, from: mealsListData)
            } catch {
                allRecipes = []
                
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
        
        func addNewMeal(_ recipe: Meal) {
            allRecipes.append(recipe)
            saveMealsList()
        }
        
        func removeMeal(_ recipe: Meal){
            allRecipes.removeAll(where: {$0 == recipe})
            saveMealsList()
        }
    
        
        
    }
