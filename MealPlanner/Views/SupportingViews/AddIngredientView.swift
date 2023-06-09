//
//  AddIngredientView.swift
//  MealPlanner
//
//  Created by Aymeric Pilaert on 13/04/2023.
//

import SwiftUI

struct AddIngredientView: View {
    @Environment(\.dismiss) var dismiss
    var ingredient: Ingredient
    var onSave: (Ingredient) -> Void
    
    @State private var name = ""
    @State private var category: Ingredient.Categories = .Others
    
    var body: some View {
        Form {
            Section {
                TextField("Ingredient", text: $name)
            } header: {
                Text("Ingredient Name")
            }
            
            Section {
                Picker(selection: $category) {
                    ForEach(Ingredient.Categories.allCases, id:\.self) { category in
                        Text(LocalizedStringKey(category.rawValue))
                    }
                } label: {
                    Label("Select a category", systemImage: "hand.point.down")
                        .font(.title3.bold())
                }
                .pickerStyle(.inline)
                
            } header: {
                Text("Category")
            }
            
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel"){dismiss()}
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save"){
                    guard name.trimmingCharacters(in: .whitespacesAndNewlines) != "" else {return}
                    var newIngredient = ingredient
                    newIngredient.category = category
                    newIngredient.id = UUID()
                    newIngredient.name = name
                    
                    onSave(newIngredient)
                    dismiss()
                }
                .disabled(name.trimmingCharacters(in: .whitespacesAndNewlines) == "")
            }
        }
        .navigationTitle("Add Ingredient")
    }
    
    init(ingredient: Ingredient, onSave: @escaping (Ingredient) -> Void) {
        self.ingredient = ingredient
        self.onSave = onSave
        
        _name = State(initialValue: name)
        _category = State(initialValue: category)
    }
    
}

struct AddIngredientView_Previews: PreviewProvider {
    static var previews: some View {
        AddIngredientView(ingredient: Ingredient.example) {_ in}
    }
}
