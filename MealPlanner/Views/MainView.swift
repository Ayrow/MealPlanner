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
    @StateObject var viewModel = ViewModel()

    var body: some View {
        NavigationStack {
            Form {
                ForEach(Days.allCases, id: \.self) { day in
                    Section(day.rawValue) {
                        Picker("Lunch", selection: Binding(get: {
                            viewModel.plannedMeals[day]?["lunch"]
                        }, set: { newValue in
                            viewModel.plannedMeals[day]?["lunch"] = newValue
                        })) {
                            Text("Pick a Meal").tag(nil as Meal?)
                            ForEach(viewModel.possibleMealsList, id: \.id) { meal in
                                Text(meal.name).tag(meal as Meal?)
                            }
                        }
                        .pickerStyle(.navigationLink)

                        Picker("Dinner", selection: Binding(get: {
                            viewModel.plannedMeals[day]?["dinner"]
                        }, set: { newValue in
                            viewModel.plannedMeals[day]?["dinner"] = newValue
                        })) {
                            Text("Pick a Meal").tag(nil as Meal?)
                            ForEach(viewModel.possibleMealsList, id: \.id) { meal in
                                Text(meal.name).tag(meal as Meal?)
                            }
                        }
                        .pickerStyle(.navigationLink)
                    }
                    .headerProminence(.increased)
                }
            }
            
            .navigationTitle("Meal Planner")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
