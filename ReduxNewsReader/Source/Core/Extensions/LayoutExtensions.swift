//
//  LayoutExtensions.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 25.05.2021.
//

import LayoutKit

public extension Layout {
    func insets(_ insets: UIEdgeInsets) -> Layout {
        InsetLayout(insets: insets, sublayout: self)
    }
    
    func center(axis: Axis) -> Layout {
        return StackLayout(
            axis: axis,
            distribution: .fillEqualSpacing,
            sublayouts: [
                SizeLayout(width: 1, height: 1),
                self,
                SizeLayout(width: 1, height: 1),
            ]
        )
    }
}
