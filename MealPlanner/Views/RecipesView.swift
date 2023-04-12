//
//  AllPossibleMealsView.swift
//  MealPlanner
//
//  Created by Aymeric Pilaert on 11/04/2023.
//

import SwiftUI

struct RecipesView: View {
    @Environment(\.isSearching) var isSearching
    @StateObject private var viewModel = RecipesViewViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                    Text("Here you can see, add, edit or remove all the meals you have in your collection.")
                        .multilineTextAlignment(.center)
                        .padding()
                
                    List {
                        ForEach(viewModel.allRecipes.sorted(), id:\.id) { meal in
                            NavigationLink {
                                // MARK: Need a navigation to a Detail View of the Meal
                            } label: {
                                Text(meal.name)
                            }
                            .swipeActions {
                                Button(role: .destructive) {
                                    viewModel.removeMeal(meal)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }

                            }
                            
                        }
                        
                    }
            }
            .navigationTitle("All Possible Meals")
            .toolbar {
                Button {
                    viewModel.showAddMealSheet.toggle()
                } label: {
                    Label("Add meal", systemImage: "plus")
                }
            }
            .sheet(isPresented: $viewModel.showAddMealSheet) {
                NavigationView {
                    AddMealView(meal: Meal(id: UUID(), name: "")){ newMeal in
                        viewModel.addNewMeal(newMeal)
                    }
                }
            }
        }
    }
    
    
    
}

struct AllPossibleMealsView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesView()
    }
}
