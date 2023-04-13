//
//  IngredientsView-ViewModel.swift
//  MealPlanner
//
//  Created by Aymeric Pilaert on 13/04/2023.
//

import Foundation

class IngredientsViewModel: ObservableObject {
    @Published private(set) var ingredients: [Ingredient]
    
    let savedPath = FileManager.documentsDirectory.appendingPathComponent("savedIngredients")
    
    init() {
        do {
            let data = try Data(contentsOf: savedPath)
            ingredients = try JSONDecoder().decode([Ingredient].self, from: data)
        } catch {
            ingredients = []
        }
    }
    
    func saveIngredients() {
        do {
            let data = try JSONEncoder().encode(ingredients)
            try data.write(to: savedPath)
        } catch {
            print("Unable to save ingredients")
        }
    }
    
    func addIngredient(_ newIngredient: Ingredient) {
        ingredients.append(newIngredient)
        saveIngredients()
    }
    
    func removeIngredient(_ ingredient: Ingredient){
        ingredients.removeAll(where: {$0 == ingredient})
        saveIngredients()
    }
    
}
