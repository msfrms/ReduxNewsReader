//
//  PageLayout.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 25.05.2021.
//

import LayoutKit

public final class PageLayout: StackLayout<UIView> {

    public init(sublayout: Layout,
                viewReuseId: String,
                cornerRadius: CGFloat = 28) {
        super.init(
            axis: .vertical,
            distribution: .leading,
            viewReuseId: viewReuseId,
            sublayouts: [
                InsetLayout(
                    insets: .top(cornerRadius),
                    sublayout: sublayout)
            ],
            config: { view in
                view.backgroundColor = .white
                view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
                view.layer.cornerRadius = cornerRadius
            }
        )
    }
}
