//
//  MainView.swift
//  MealPlanner
//
//  Created by Aymeric Pilaert on 11/04/2023.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                    Color("LaunchScreenBackgroundColor")
                    
                    VStack {
                        HStack {
                            Text("Monday")
                            Spacer()
                            VStack {
                                HStack {
                                    Text("Lunch: ")
                                    Text("Picker goes here")
                                }
                                HStack {
                                    Text("Lunch: ")
                                    Text("Picker goes here")
                                }
                            }
                        }
                        .padding()
                    }
                }
                .ignoresSafeArea()
            .navigationTitle("Meal Planner")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
