//
//  MainView.swift
//  MealPlanner
//
//  Created by Aymeric Pilaert on 11/04/2023.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewViewModel()
    @EnvironmentObject var dishesVM: DishesViewViewModel
    
    @State private var showConfirmationDialog = false
    
    @State private var showPickerDishView = false
    @State private var tempDay = MealsPlan.DaysOfWeek.Monday
    @State private var tempMealtime = MealsPlan.Mealtime.Lunch
    @State private var showDishDetailsSheet = false
    
    var body: some View {
        NavigationStack {
                Form {
                    ForEach(MealsPlan.DaysOfWeek.allCases, id: \.self) { day in
                        Section(LocalizedStringKey(day.rawValue)) {
                            ForEach(MealsPlan.Mealtime.allCases, id: \.self) { mealTime in
                                
                                HStack {
                                    Text(LocalizedStringKey(mealTime.rawValue))
                                    Spacer()
                                    Button {
                                        tempDay = day
                                        tempMealtime = mealTime
                                        showPickerDishView.toggle()
                                    } label: {
                                        HStack {
                                            Text(viewModel.weekMeals[day, mealTime]?.name ?? "")
                                            Image(systemName: "chevron.right")
                                        }
                                        .foregroundColor((viewModel.weekMeals[day, mealTime] != nil) ? Color.green : Color.blue)
                                    }
                                }
                                .contextMenu {
                                    if viewModel.weekMeals[day, mealTime] != nil {
                                        Button("Show recipe"){
                                            tempDay = day
                                            tempMealtime = mealTime
                                            showDishDetailsSheet.toggle()
                                        }
                                    }
                                }
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
                        showConfirmationDialog.toggle()
                    }
                    .disabled(viewModel.checkIfNoMealPlanned())
                }
                .confirmationDialog("Are you sure?", isPresented: $showConfirmationDialog, actions: {
                    Button("Cancel", role: .cancel){}
                    Button("Delete", role: .destructive){
                        viewModel.weekMeals.reset()
                    }
                }, message: {
                    Text("Are you sure?")
                })
                .sheet(isPresented: $showPickerDishView) {
                    NavigationView {
                        PickerDishView(day: tempDay, mealTime: tempMealtime){ dish in
                            viewModel.weekMeals[tempDay, tempMealtime] = dish
                        }
                    }
                }
                .sheet(isPresented: $showDishDetailsSheet) {
                    DishDetailsView(dish: viewModel.weekMeals[tempDay, tempMealtime]!)
                }
                
        }
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(DishesViewViewModel())
    }
}
