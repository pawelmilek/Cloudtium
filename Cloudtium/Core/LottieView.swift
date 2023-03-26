//
//  LottieView.swift
//  Cloudtium
//
//  Created by Pawel Milek on 27/12/2022.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
  var name = "weather-icon-mostly-sunny"
  var loopMode: LottieLoopMode = .loop
  let animationView = LottieAnimationView()

  func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
    let view = UIView(frame: .zero)

    let animation = LottieAnimation.named(name)
    animationView.animation = animation
    animationView.contentMode = .scaleAspectFit
    animationView.loopMode = loopMode
    animationView.play()

    animationView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(animationView)
    NSLayoutConstraint.activate([
      animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
      animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
    ])

    return view
  }

  func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
  }
}
