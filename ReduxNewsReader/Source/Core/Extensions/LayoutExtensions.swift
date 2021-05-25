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
}
