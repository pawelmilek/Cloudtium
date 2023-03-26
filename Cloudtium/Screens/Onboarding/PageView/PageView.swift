//
//  PageView.swift
//  Cloudtium
//
//  Created by Pawel Milek on 7/15/23.
//

import SwiftUI

struct PageView: View {
    @ObservedObject var viewModel: PageViewModel

    var body: some View {
        VStack {
            BigLogoView(
                imageName: viewModel.symbol,
                gradientColors: viewModel.gradientColors
            )
            .padding(.bottom, 60)
            DescriptionView(
                title: viewModel.title,
                subheadline: viewModel.subheadline
            )
            .padding(.bottom, 10)
            PageActionView(
                buttonTitle: viewModel.buttonTitle,
                onPrimaryAction: viewModel.onPrimaryAction,
                onSecondaryAction: viewModel.onSecondaryAction
            )
            .opacity(viewModel.page == .share ? 1.0 : 0.0)
        }
        .padding(.horizontal, 35)
        .padding(.bottom, 45)
        .background(ColorStyle.background)
        .frameAlignment(.bottom)
    }
}

struct PageView_Previews: PreviewProvider {
    static let findViewModel = PageViewModel.makeFirstPageViewModel()
    static let shareViewModel = PageViewModel.makeSecondPageViewModel()

    static var previews: some View {
        PageView(viewModel: findViewModel)
        PageView(viewModel: shareViewModel)
    }
}
