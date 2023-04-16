//
//  ContentView-ViewModel.swift
//  MealPlanner
//
//  Created by Aymeric Pilaert on 11/04/2023.
//

import Foundation
import SwiftUI

    @MainActor class DishesViewViewModel: ObservableObject {
        
        @Published private(set) var allDishes: [Dish]
        @Published var showAddDishSheet = false
        @Published var searchDishes = ""
        
        let savedPathForDishes = FileManager.documentsDirectory.appendingPathComponent("savedRecipes")
        
        init() {
            do {
                let dishesData = try Data(contentsOf: savedPathForDishes)
                allDishes = try JSONDecoder().decode([Dish].self, from: dishesData)
            } catch {
                allDishes = []
                
            }
        }
        
        func saveDishesList() {
            do {
                let data = try JSONEncoder().encode(allDishes)
                try data.write(to: savedPathForDishes)
            } catch {
                print("Cannot save to meals list")
            }
        }
        
        func addDish(_ recipe: Dish) {
            if let i = allDishes.firstIndex(where: {$0 == recipe}){
                allDishes[i] = recipe
            } else {
                allDishes.append(recipe)
            }
            saveDishesList()
        }
        
        func deleteDish(_ recipe: Dish){
            allDishes.removeAll(where: {$0 == recipe})
            saveDishesList()
        }
    
        
        
    }
