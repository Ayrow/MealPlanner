//
//  AddMealView.swift
//  MealPlanner
//
//  Created by Aymeric Pilaert on 11/04/2023.
//

import SwiftUI

struct AddDishView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var ingredientsVM: IngredientsViewModel
    
    var dish: Dish
    var onSave: (Dish) -> Void
    
    @State var name = ""
    @State var recipe = ""
    @State var ingredientsRecipe: [Ingredient?] = []
    @State private var selectedIngredient: Ingredient?
    @State private var showIngredientsPickerSheet = false
    var body: some View {
        VStack {
            Form {
                Section("Dish name") {
                    TextField("Enter name of the dish", text: $name)
                }
                Section("Recipe") {
                    TextField("Enter the full URL for the recipe", text: $recipe)
                    
                }
                Section("Ingredients") {
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
            
            Button(ingredientsRecipe.isEmpty ? "Add Ingredients" : "Edit Ingredients"){
                showIngredientsPickerSheet.toggle()
            }.padding(.top)
            
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel"){
                    dismiss()
                }
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
        .sheet(isPresented: $showIngredientsPickerSheet, content: {
            NavigationStack {
                PickerIngredientsView(ingredientsRecipe: $ingredientsRecipe)
            }
        })
    .navigationTitle("Add Dish")
    }
    
    init(dish: Dish, onSave: @escaping (Dish) -> Void) {
        self.dish = dish
        self.onSave = onSave
        
        _name = State(initialValue: dish.name)
        _recipe = State(initialValue: dish.recipe ?? "")
        _ingredientsRecipe = State(initialValue: dish.ingredients)
    }
    
    
    func fetchRecipe() {
    }
    
}

struct AddMealView_Previews: PreviewProvider {
    static var previews: some View {
        AddDishView(dish: Dish.example){_ in}
            .environmentObject(IngredientsViewModel())
    }
}
