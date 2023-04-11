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
    private let timeOfDay = ["Lunch", "Dinner", "Lunch + Dinner"]
    @State private var selectedMealType = "Dinner"
    
    var body: some View {
        NavigationStack {
            ZStack {
                    Color("LaunchScreenBackgroundColor")
                        .ignoresSafeArea()
                    
                ScrollView(showsIndicators: false) {
                        
                        ForEach(Days.allCases, id: \.rawValue) { day in
                            VStack {
                                Text(day.rawValue)
                                    .font(.title.bold())
                                
                                VStack {
                                    Text("Lunch:  ")
                                        .font(.title2)
                                        .multilineTextAlignment(.leading)
                                        .padding()
                                    
                                    Text("Dinner:  ")
                                        .font(.title2)
                                        .multilineTextAlignment(.leading)
                                        .padding()
                                }
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.85)
                            .padding()
                            .background(Color("BlackWhite").opacity(0.8))
                            .clipShape(
                                RoundedRectangle(cornerRadius: 20)
                            )
                            .shadow(color: .gray, radius: 5)
                            .padding(.vertical, 10)
                        }
                        
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
