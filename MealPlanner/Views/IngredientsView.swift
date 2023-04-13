//
//  IngredientsView.swift
//  MealPlanner
//
//  Created by Aymeric Pilaert on 13/04/2023.
//

import SwiftUI

struct IngredientsView: View {
    @EnvironmentObject var allIngredients: IngredientsViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                    Text(LocalizedStringKey("Here you can see, add, edit or remove all the ingredients you have in your collection."))
                        .multilineTextAlignment(.center)
                        .padding()
                
                    List {
                        ForEach(Ingredient.Categories.allCases, id:\.self) { category in
                            Section {
                                ForEach(allIngredients.ingredients.filter {$0.category == category}.sorted {$0.name < $1.name}) { ingredient in
                                    Text(ingredient.name)
                                        .swipeActions {
                                            Button(role: .destructive) {
                                                allIngredients.removeIngredient(ingredient)
                                            } label: {
                                                Label("Delete", systemImage: "trash")
                                            }

                                        }

                                }
                                
                            } header: {
                                Text(category.rawValue)
                            }
                            
                        }
                        
                    }
            }
            .navigationTitle("Your Ingredients")
            .toolbar {
                Button {
                    allIngredients.showAddIngredientSheet.toggle()
                } label: {
                    Label(LocalizedStringKey("Add ingredient"), systemImage: "plus")
                }
            }
            .sheet(isPresented: $allIngredients.showAddIngredientSheet) {
                NavigationView {
                    AddIngredientView(ingredient: Ingredient(name: "", category: Ingredient.Categories.Others)) { newIngredient in
                        allIngredients.addIngredient(newIngredient)
                    }
                }
            }
        }
    }
}

struct IngredientsView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientsView()
            .environmentObject(IngredientsViewModel())
    }
}
