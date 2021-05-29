//
//  ShadowLayout.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 26.05.2021.
//

import LayoutKit

public final class ShadowLayout: InsetLayout<UIView> {
    
    public enum Styles {
        public enum Shadow {
            case black
            case blue
            case card
        }
        case shadow(Shadow)
    }
    
    public init(
        sublayout: Layout,
        viewReuseId: String,
        styles: Styles = .shadow(.black),
        insets: UIEdgeInsets = .init(3)) {
        super.init(
            insets: insets,
            viewReuseId: viewReuseId,
            sublayout: sublayout,
            config: { view in
                switch styles {
                case .shadow(.black):
                    view.layer.applyFigmaShadow(
                        color: Asset.Colors.black.color,
                        alpha: 0.44,
                        x: 0,
                        y: 16,
                        blur: 32,
                        spread: 0
                    )
                case .shadow(.blue):
                    view.layer.applyFigmaShadow(
                        color: Asset.Colors.black.color,
                        alpha: 0.06,
                        x: 0,
                        y: 10,
                        blur: 15,
                        spread: 0
                    )
                case .shadow(.card):
                    view.backgroundColor = .white
                    view.layer.applyFigmaShadow(
                        color: Asset.Colors.blue.color,
                        alpha: 0.06,
                        x: 0,
                        y: 10,
                        blur: 15,
                        spread: 5
                    )
                }
            }
        )
    }
}
