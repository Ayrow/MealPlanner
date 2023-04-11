//
//  AddMealView.swift
//  MealPlanner
//
//  Created by Aymeric Pilaert on 11/04/2023.
//

import SwiftUI

struct AddMealView: View {
    @Environment(\.dismiss) var dismiss
    
    var meal: Meal
    var onSave: (Meal) -> Void
    
    @State var name = ""
    @State var recipe = ""
    @State var ingredients = [""]
    
    var body: some View {
        Form {
            Text("Hello")
        }
        .toolbar {
            Button("Save"){
                var newMeal = meal
                newMeal.name = name
                newMeal.recipe = URL(string: recipe)
                newMeal.ingredients = ingredients
                
                onSave(newMeal)
                dismiss()
            }
        }
        .navigationTitle("Add Meal")
    }
    
    init(meal: Meal, onSave: @escaping (Meal) -> Void) {
        self.meal = meal
        self.onSave = onSave
        
        _name = State(initialValue: name)
        _recipe = State(initialValue: recipe)
        _ingredients = State(initialValue: ingredients)
    }
    
}

struct AddMealView_Previews: PreviewProvider {
    static var previews: some View {
        AddMealView(meal: Meal.example){_ in}
    }
}
