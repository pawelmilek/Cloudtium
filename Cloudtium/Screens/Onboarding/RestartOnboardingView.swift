//
//  RestartOnboardingView.swift
//  Cloudtium
//
//  Created by Pawel Milek on 7/30/23.
//

import SwiftUI

struct RestartOnboardingView: View {
    @EnvironmentObject var stateManager: ApplicationStateManager

    var body: some View {
        ZStack {
            BackgroundView(color: ColorStyle.background)
            Button(action: {
                withAnimation {
                    stateManager.onboarding()
                }
            }, label: {
                Text("Restart Onboarding")
                    .fontWeight(.heavy)
                    .fontDesign(.rounded)
                    .frame(maxWidth: .infinity, maxHeight: 80)
            })
            .foregroundColor(.white)
            .background(Color("secondary"))
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 10,
                    style: .continuous
                )
            )
            .padding(.horizontal, 50)
        }
    }
}

struct StartOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        RestartOnboardingView()
            .environmentObject(ApplicationStateManager())
    }
}
