//
//  AllPossibleMealsView.swift
//  MealPlanner
//
//  Created by Aymeric Pilaert on 11/04/2023.
//

import SwiftUI

struct DishView: View {
    @EnvironmentObject var dishesVM: DishesViewViewModel
    @State var mealToEdit = Dish(name: "", ingredients: [])
    let emptyMealData = Dish(name: "", ingredients: [])
    @State private var showConfirmationAlert = false
    
    var body: some View {
        NavigationStack {
                List {
                    if filteredDishes.isEmpty {
                        Text("No dish found")
                    } else {
                        ForEach(filteredDishes.sorted(), id:\.id) { meal in
                            NavigationLink {
                                NavigationView {
                                    DishDetailsView(dish: meal)
                                }
                            } label: {
                                Text(meal.name)
                            }
                            .alert("Are you sure?", isPresented: $showConfirmationAlert, actions: {
                                Button("Cancel", role: .cancel){}
                                Button("Delete", role: .destructive){
                                    dishesVM.deleteDish(meal)
                                }
                            })
                            .swipeActions {
                                Button(role: .destructive) {
                                    showConfirmationAlert.toggle()
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                                
                                Button {
                                    mealToEdit = meal
                                    dishesVM.showAddDishSheet.toggle()
                                } label: {
                                    Label("Edit", systemImage: "pencil")
                                }
                                .tint(.orange)


                            }
                            
                        }
                    }
                    
                }
            
                .searchable(text: $dishesVM.searchDishes, prompt: "Search for a dish")
            .navigationTitle("My Dishes")
            .toolbar {
                Button {
                    dishesVM.showAddDishSheet.toggle()
                    mealToEdit = emptyMealData
                } label: {
                    Label("Add dish", systemImage: "plus")
                }
            }
            .sheet(isPresented: $dishesVM.showAddDishSheet) {
                NavigationView {
                    AddDishView(dish: mealToEdit){ newMeal in
                        mealToEdit = emptyMealData
                        dishesVM.addDish(newMeal)
                    }
                }
            }
        }
    }
   
    var filteredDishes: [Dish] {
        if dishesVM.searchDishes.isEmpty {
            return dishesVM.allDishes
        } else {
            return dishesVM.allDishes.filter {$0.name.contains(dishesVM.searchDishes)}
        }
    }
    
}

struct AllPossibleMealsView_Previews: PreviewProvider {
    static var previews: some View {
        DishView()
            .environmentObject(DishesViewViewModel())
    }
}
