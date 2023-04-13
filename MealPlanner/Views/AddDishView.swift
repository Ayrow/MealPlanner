//
//  AddMealView.swift
//  MealPlanner
//
//  Created by Aymeric Pilaert on 11/04/2023.
//

import SwiftUI

struct AddDishView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var allIngredients: IngredientsViewModel
    
    var dish: Dish
    var onSave: (Dish) -> Void
    
    @State var name = ""
    @State var recipe = ""
    @State var ingredientsRecipe: [Ingredient?] = []
    @State private var selectedIngredient: Ingredient?
    
    var body: some View {
        Form {
            Section("Meal") {
                TextField("Enter the name of a meal", text: $name)
            }
            Section("Recipe") {
                TextField("Enter the full URL of the recipe", text: $recipe)
            }
            Section("Ingredients") {
                
                    Picker("Select an ingredient" ,selection: $selectedIngredient) {
                        Text("Select one").tag(Optional<Ingredient>(nil))
                        ForEach(allIngredients.ingredients, id:\.self) { ingredient in
                            Text(ingredient.name).tag(ingredient as Ingredient?)
                        }
                    }
                    .pickerStyle(.menu)
                
                Button("Add"){
                    guard ingredientsRecipe.contains(selectedIngredient) == false, selectedIngredient?.name != "" else {return}
                    
                    ingredientsRecipe.append(selectedIngredient)
                }
                
                List {
                    if ingredientsRecipe.isEmpty == false {
                        ForEach(ingredientsRecipe, id: \.self) { ingredient in
                            Text(ingredient?.name ?? Ingredient.example.name)
                                .swipeActions {
                                    Button(role: .destructive) {
                                        ingredientsRecipe.removeAll(where: {$0 == ingredient})
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }

                                }
                        }
                    } else {
                        Text("No ingredients added yet")
                    }
                }

            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel"){dismiss()}
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save"){
                    guard name.trimmingCharacters(in: .whitespacesAndNewlines) != "" else {return}
                    var newDish = dish
                    newDish.name = name
                    newDish.recipe = recipe
                    newDish.ingredients = ingredientsRecipe
                    
                    onSave(newDish)
                    dismiss()
                }
                .disabled(name.trimmingCharacters(in: .whitespacesAndNewlines) == "")
            }
        }
        .navigationTitle("Add Meal")
    }
    
    init(dish: Dish, onSave: @escaping (Dish) -> Void) {
        self.dish = dish
        self.onSave = onSave
        
        _name = State(initialValue: name)
        _recipe = State(initialValue: recipe)
        _ingredientsRecipe = State(initialValue: ingredientsRecipe)
    }
    
}

struct AddMealView_Previews: PreviewProvider {
    static var previews: some View {
        AddDishView(dish: Dish.example){_ in}
            .environmentObject(IngredientsViewModel())
    }
}
