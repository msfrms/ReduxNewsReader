//
//  PageLayout.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 25.05.2021.
//

import LayoutKit

public class PageLayout: StackLayout<UIView> {

    public init(sublayout: Layout,
                viewReuseId: String,
                cornerRadius: CGFloat = 28) {
        super.init(
            axis: .vertical,
            distribution: .leading,
            sublayouts: [
                InsetLayout(
                    insets: .init(top: cornerRadius, left: 0, bottom: 0, right: 0),
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
