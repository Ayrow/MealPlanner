//
//  IngredientsView-ViewModel.swift
//  MealPlanner
//
//  Created by Aymeric Pilaert on 13/04/2023.
//

import Foundation

class IngredientsViewModel: ObservableObject {
    @Published private(set) var allIngredients: [Ingredient]
    
    let savedPath = FileManager.documentsDirectory.appendingPathComponent("savedIngredients")
    
    init() {
        do {
            let data = try Data(contentsOf: savedPath)
            allIngredients = try JSONDecoder().decode([Ingredient].self, from: data)
        } catch {
            allIngredients = []
        }
    }
    
    
    func saveIngredients() {
        do {
            let data = try JSONEncoder().encode(allIngredients)
            try data.write(to: savedPath)
        } catch {
            print("Unable to save ingredients")
        }
    }
    
    func addIngredient(_ newIngredient: Ingredient) {
        allIngredients.append(newIngredient)
        saveIngredients()
    }
    
    func removeIngredient(_ ingredient: Ingredient){
        allIngredients.removeAll(where: {$0 == ingredient})
        saveIngredients()
    }
}
