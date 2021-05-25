//
//  GeometryExtensions.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 25.05.2021.
//

import UIKit

public extension UIEdgeInsets {

    static func top(_ top: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets.zero.top(top)
    }

    static func bottom(_ bottom: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets.zero.bottom(bottom)
    }

    static func left(_ left: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets.zero.left(left)
    }

    static func right(_ right: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets.zero.right(right)
    }

    init(_ value: CGFloat) {
        self = .init(top: value, left: value, bottom: value, right: value)
    }

    func top(_ top: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }

    func bottom(_ bottom: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }

    func left(_ left: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }

    func right(_ right: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
}

extension CGRect {

    func x(_ x: CGFloat) -> CGRect {
        .init(x: x, y: origin.y, width: width, height: height)
    }

    func y(_ y: CGFloat) -> CGRect {
        .init(x: origin.x, y: y, width: width, height: height)
    }

    func width(_ width: CGFloat) -> CGRect {
        .init(x: origin.x, y: origin.y, width: width, height: height)
    }

    func height(_ height: CGFloat) -> CGRect {
        .init(x: origin.x, y: origin.y, width: width, height: height)
    }
}
