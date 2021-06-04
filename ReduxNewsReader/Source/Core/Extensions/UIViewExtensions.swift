//
//  UIViewExtensions.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 26.05.2021.
//

import UIKit
import SkeletonView

extension UIView {

    func pin(to view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor),
            leftAnchor.constraint(equalTo: view.leftAnchor),
            rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }

    func pin(to guide: UILayoutGuide) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: guide.topAnchor),
            bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            leftAnchor.constraint(equalTo: guide.leftAnchor),
            rightAnchor.constraint(equalTo: guide.rightAnchor)
        ])
    }


    func reuseView<T: UIView>(by id: String) -> T? {
        guard viewReuseId != id else {
            return self as? T
        }
        for view in subviews {
            let reuse: T? = view.reuseView(by: id)
            if reuse != nil {
                return reuse
            }
        }
        return nil
    }
    
    func recursiveShowAnimatedSkeleton(view: UIView) {
        view.subviews.forEach {
            recursiveShowAnimatedSkeleton(view: $0)
        }

        view.showAnimatedSkeleton(
            usingColor: Asset.Colors.lightGray.color,
            animation: nil,
            transition: .none
        )
    }
    
    func recursiveHideAnimatedSkeleton(view: UIView) {
        view.subviews.forEach {
            recursiveHideAnimatedSkeleton(view: $0)
        }
        view.isSkeletonable = false
        view.hideSkeleton(reloadDataAfter: false, transition: .none)
    }
}
