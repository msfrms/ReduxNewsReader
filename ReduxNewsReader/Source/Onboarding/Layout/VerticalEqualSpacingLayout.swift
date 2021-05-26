//
//  EqualSpacingLayout.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 26.05.2021.
//

import LayoutKit

public final class VerticalEqualSpacingLayout: StackLayout<UIView> {

    public init(sublayouts: [Layout], maxHeight: CGFloat) {
        let height = sublayouts.reduce(0) { height, layout in
            layout.arrangement(origin: .zero).frame.height + height
        }
        
        let freeHeight = maxHeight - height
        let spacing = (freeHeight / CGFloat(sublayouts.count + 2))
        
        super.init(
            axis: .vertical,
            distribution: .fillEqualSpacing,
            sublayouts: [
                [SizeLayout(height: spacing)],
                sublayouts
            ].flatMap { $0 }
        )
    }
}
