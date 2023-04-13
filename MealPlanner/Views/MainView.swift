//
//  MainView.swift
//  MealPlanner
//
//  Created by Aymeric Pilaert on 11/04/2023.
//

import SwiftUI

enum Days: String, CaseIterable {
    case Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday
}

struct MainView: View {
    @StateObject var viewModel = MainViewViewModel()
    @EnvironmentObject var recipes: RecipesViewViewModel
    
   // private let timeOfDay = ["Lunch", "Dinner", "Lunch + Dinner"]
   // @State private var selectedMealType = "Dinner"
    
    var body: some View {
        NavigationStack {
                Form {
                    ForEach(MealsPlan.DaysOfWeek.allCases, id: \.self) { day in
                                    Section(day.rawValue) {
                                        ForEach(MealsPlan.Mealtime.allCases, id: \.self) { mealTime in
                                            Picker(mealTime.rawValue, selection: $viewModel.weekMeals[day, mealTime]) {
                                            Text("Pick a Dish").tag(Optional<Dish>(nil))
                                                
                                                ForEach(recipes.allRecipes.sorted(), id:\.self) { dish in
                                                    Text(dish.name).tag(dish as Dish?)
                                                        .foregroundColor(.blue)
                                                   }
                                               }
                                               .pickerStyle(.navigationLink)
                                           }
                                       }
                                       .headerProminence(.increased)
                                   }
                }
                .onChange(of: viewModel.weekMeals, perform: { _ in
                    viewModel.saveWeekMeals()
                })
                .navigationTitle("Meal Planner")
                .toolbar {
                    Button("Clear All"){
                        viewModel.weekMeals.reset()
                    }
                }
        }
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(RecipesViewViewModel())
    }
}
