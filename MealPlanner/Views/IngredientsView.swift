//
//  IngredientsView.swift
//  MealPlanner
//
//  Created by Aymeric Pilaert on 13/04/2023.
//

import SwiftUI

struct IngredientsView: View {
    @EnvironmentObject var ingredientsVM: IngredientsViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                    List {
                        if ingredientsVM.ingredientSearch.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            ForEach(Ingredient.Categories.allCases, id:\.self) { category in
                                Section {
                                    ForEach(ingredientsVM.ingredients.filter {$0.category == category}.sorted {$0.name < $1.name}) { ingredient in
                                        Text(ingredient.name)
                                            .swipeActions {
                                                Button(role: .destructive) {
                                                    ingredientsVM.removeIngredient(ingredient)
                                                } label: {
                                                    Label("Delete", systemImage: "trash")
                                                }

                                            }

                                    }
                                    
                                } header: {
                                    Text(LocalizedStringKey(category.rawValue))
                                }
                                
                            }
                        } else {
                            if filteredIngredients.isEmpty {
                                Text("No matching ingredient")
                            } else {
                                ForEach(filteredIngredients.sorted {$0!.name < $1!.name}, id:\.self) { ingredient in
                                    Text(ingredient!.name)
                                        .swipeActions {
                                            Button(role: .destructive) {
                                                ingredientsVM.removeIngredient(ingredient!)
                                            } label: {
                                                Label("Delete", systemImage: "trash")
                                            }

                                        }

                                }
                            }
                            
                            
                        }
                        
                        
                    }
            }
            .searchable(text: $ingredientsVM.ingredientSearch, prompt: "Search Ingredient")
            .navigationTitle("My Ingredients")
            .toolbar {
                Button {
                    ingredientsVM.showAddIngredientSheet.toggle()
                } label: {
                    Label(LocalizedStringKey("Add ingredient"), systemImage: "plus")
                }
            }
            .sheet(isPresented: $ingredientsVM.showAddIngredientSheet) {
                NavigationView {
                    AddIngredientView(ingredient: Ingredient(name: "", category: Ingredient.Categories.Others)) { newIngredient in
                        ingredientsVM.addIngredient(newIngredient)
                    }
                }
            }
        }
    }
    
    var filteredIngredients: [Ingredient?] {
        ingredientsVM.ingredients.filter { $0.name.contains(ingredientsVM.ingredientSearch) }
    }
    
}

struct IngredientsView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientsView()
            .environmentObject(IngredientsViewModel())
    }
}
