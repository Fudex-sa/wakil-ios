//
//  LayerFontProvider.swift
//  Lottie
//
//  Created by Brandon Withrow on 8/5/20.
//  Copyright © 2020 YurtvilleProds. All rights reserved.
//

/// Connects a LottieFontProvider to a group of text layers
@available(iOS 13.0.0, *)
final class LayerFontProvider {

  // MARK: Lifecycle

  init(fontProvider: AnimationFontProvider) {
    self.fontProvider = fontProvider
    textLayers = []
    reloadTexts()
  }

  // MARK: Internal

  private(set) var textLayers: [TextCompositionLayer]

  var fontProvider: AnimationFontProvider {
    didSet {
      reloadTexts()
    }
  }

  func addTextLayers(_ layers: [TextCompositionLayer]) {
    textLayers += layers
  }

  func reloadTexts() {
    for textLayer in textLayers {
      textLayer.fontProvider = fontProvider
    }
  }
}
