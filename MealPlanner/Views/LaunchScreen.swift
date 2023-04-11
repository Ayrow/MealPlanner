//
//  LaunchScreen.swift
//  MealPlanner
//
//  Created by Aymeric Pilaert on 11/04/2023.
//

import SwiftUI

struct LaunchScreen: View {
   @Binding var splashLoaded: Bool
    @State private var scale = 0.0
    var body: some View {
        ZStack {
            Color("LaunchScreenBackgroundColor")
            
            VStack {
                Image("MealPlanner-icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("Meal Planner")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 4)
            }
            .animation(.interactiveSpring(
                response: 0.75,
                dampingFraction: 0.4,
                blendDuration: 1.5
            ), value: scale)
            .onAppear() {
                scale = 1
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    withAnimation {
                        self.splashLoaded = true
                    }
                }
            }
            
        }
        .ignoresSafeArea()
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen(splashLoaded: .constant(true))
    }
}
