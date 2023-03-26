//
//  PageView.swift
//  Cloudtium
//
//  Created by Pawel Milek on 7/15/23.
//

import SwiftUI

final class PageViewModel: ObservableObject, Identifiable {
    var symbol: String { model.symbol }
    var title: AttributedString {
        let mutableAttributedString = NSMutableAttributedString(string: model.title)
        mutableAttributedString.replace(
            model.titleColorWord,
            attributes: [.foregroundColor: UIColor(ColorStyle.secondary)]
        )
        let tttributedString = try? AttributedString((mutableAttributedString as NSAttributedString), including: \.uiKit)
        return tttributedString ?? AttributedString()
    }
    var subheadline: String { model.subheadline }
    var buttonTitle: (primary: String, secondary: String) { model.buttonTitle ?? ("", "") }
    let gradientColors: [Color] = [Color("primary"), Color("secondary")]

    var onPrimaryAction: (() -> Void)?
    var onSecondaryAction: (() -> Void)?

    let page: OnboardingPage
    @Published private var model: PageModel

    init(page: OnboardingPage, model: PageModel) {
        self.page = page
        self.model = model
    }
}

// MARK: - Factory methods
extension PageViewModel {

    static func makeFirstPageViewModel() -> PageViewModel {
        let model = PageModel.firstPageModel
        let viewModel = PageViewModel(page: .find, model: model)
        return viewModel
    }

    static func makeSecondPageViewModel() -> PageViewModel {
        let model = PageModel.secondPageModel
        let viewModel = PageViewModel(page: .share, model: model)
        return viewModel
    }

}
