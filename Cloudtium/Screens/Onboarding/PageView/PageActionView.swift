//
//  PageActionView.swift
//  Cloudtium
//
//  Created by Pawel Milek on 6/17/23.
//

import SwiftUI

struct PageActionView: View {
    @Environment(\.dismiss) var dismiss

    let buttonTitle: (primary: String, secondary: String)
    let onPrimaryAction: (() -> Void)?
    let onSecondaryAction: (() -> Void)?

    var body: some View {
        VStack(spacing: 5) {
            Button {
                onPrimaryAction?()
                dismiss()
            } label: {
                Text(buttonTitle.primary)
            }
            .buttonStyle(AccentButtonStyle())
            Button {
                onSecondaryAction?()
                dismiss()
            } label: {
                Text(buttonTitle.secondary)
            }
            .buttonStyle(ClearAccentButtonStyle())
        }
        .fontWeight(.bold)
        .fontDesign(.rounded)
    }
}

struct PageActionView_Previews: PreviewProvider {
    static let viewModel = PageViewModel.makeSecondPageViewModel()

    static var previews: some View {
        PageActionView(
            buttonTitle: viewModel.buttonTitle,
            onPrimaryAction: viewModel.onPrimaryAction,
            onSecondaryAction: viewModel.onSecondaryAction
        )
        .previewLayout(.sizeThatFits)
    }
}
