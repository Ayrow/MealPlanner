//
//  AllPossibleMealsView.swift
//  MealPlanner
//
//  Created by Aymeric Pilaert on 11/04/2023.
//

import SwiftUI

struct RecipesView: View {
    @EnvironmentObject var recipes: RecipesViewViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                    Text("Here you can see, add, edit or remove all the dishes you have in your collection.")
                        .multilineTextAlignment(.center)
                        .padding()
                
                    List {
                        ForEach(recipes.allRecipes.sorted(), id:\.id) { meal in
                            NavigationLink {
                                // MARK: Need a navigation to a Detail View of the Meal
                                NavigationView {
                                    RecipeDetailsView(meal: meal)
                                }
                            } label: {
                                Text(meal.name)
                            }
                            .swipeActions {
                                Button(role: .destructive) {
                                    recipes.removeMeal(meal)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }

                            }
                            
                        }
                        
                    }
            }
            .navigationTitle("Your Dishes")
            .toolbar {
                Button {
                    recipes.showAddMealSheet.toggle()
                } label: {
                    Label("Add dish", systemImage: "plus")
                }
            }
            .sheet(isPresented: $recipes.showAddMealSheet) {
                NavigationView {
                    AddDishView(dish: Dish(id: UUID(), name: "", ingredients: [String](), recipe: "")){ newMeal in
                        recipes.addNewMeal(newMeal)
                    }
                }
            }
        }
    }
   
    
}

struct AllPossibleMealsView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesView()
            .environmentObject(RecipesViewViewModel())
    }
}
