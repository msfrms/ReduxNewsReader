//
//  ShadowLayout.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 26.05.2021.
//

import LayoutKit

public final class ShadowLayout: InsetLayout<UIView> {
    
    public init(sublayout: Layout, viewReuseId: String, insets: UIEdgeInsets = .init(3)) {
        super.init(
            insets: insets,
            viewReuseId: viewReuseId,
            sublayout: sublayout,
            config: { view in
                view.layer.applyFigmaShadow(
                    color: Asset.Colors.black.color,
                    alpha: 0.44,
                    x: 0,
                    y: 16,
                    blur: 32,
                    spread: 0
                )
            }
        )
    }
}
