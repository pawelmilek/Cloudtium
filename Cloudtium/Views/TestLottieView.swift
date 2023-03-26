//
//  TestLottieView.swift
//  Cloudtium
//
//  Created by Pawel Milek on 27/12/2022.
//

import SwiftUI

struct TestLottieView: View {
  var body: some View {
    VStack(alignment: .center) {
      LottieView()
    }
  }
}

struct TestLottieView_Previews: PreviewProvider {
  static var previews: some View {
    TestLottieView()
      .padding()
      .previewLayout(.sizeThatFits)
  }
}
