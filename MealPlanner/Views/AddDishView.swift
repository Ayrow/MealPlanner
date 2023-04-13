//
//  AddMealView.swift
//  MealPlanner
//
//  Created by Aymeric Pilaert on 11/04/2023.
//

import SwiftUI

struct AddDishView: View {
    @Environment(\.dismiss) var dismiss
    
    var dish: Dish
    var onSave: (Dish) -> Void
    
    @State var name = ""
    @State var recipe = ""
    @State var ingredients: [String] = [""]
    
    var body: some View {
        Form {
            Section("Meal") {
                TextField("Enter the name of a meal", text: $name)
            }
            Section("Recipe") {
                TextField("Enter the full URL of the recipe", text: $recipe)
            }
            Section("Ingredients") {
                ForEach(0..<ingredients.count, id:\.self) { index in
                    TextField("Ingredient \(index)", text: self.$ingredients[index])
                }
                Button {
                    self.ingredients.append("")
                } label: {
                    Label("Add more", systemImage: "plus.circle")
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel"){dismiss()}
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save"){
                    var newDish = dish
                    newDish.name = name
                    newDish.recipe = recipe
                    newDish.ingredients = ingredients
                    
                    onSave(newDish)
                    dismiss()
                }
            }
        }
        .navigationTitle("Add Meal")
    }
    
    init(dish: Dish, onSave: @escaping (Dish) -> Void) {
        self.dish = dish
        self.onSave = onSave
        
        _name = State(initialValue: name)
        _recipe = State(initialValue: recipe)
        _ingredients = State(initialValue: ingredients)
    }
    
}

struct AddMealView_Previews: PreviewProvider {
    static var previews: some View {
        AddDishView(dish: Dish.example){_ in}
    }
}
