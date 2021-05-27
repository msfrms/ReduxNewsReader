//
//  CategoryLayout.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 27.05.2021.
//

import LayoutKit

public final class CategoryLayout: OverlayLayout<UIView> {
    public struct Props {
        public let title: String
        public let image: UIImage
    }
    
    public init(props: Props, viewReuseId: String) {
        super.init(
            primaryLayouts: [
                SizeLayout<UIImageView>(width: 236, height: 273, config: { view in
                    view.image = props.image
                })
            ],
            overlayLayouts: [
                StackLayout(
                    axis: .vertical,
                    distribution: .fillEqualSpacing,
                    sublayouts: [
                        SizeLayout(height: 1),
                        LabelLayout(
                            attributedText: .init(
                                string: props.title,
                                attributes: [
                                    .font: UIFont.systemFont(ofSize: 18, weight: .heavy),
                                    .kern: 1,
                                    .foregroundColor: UIColor.white
                                ]
                            )
                        ).insets(.left(25).bottom(31))
                    ]
                ),
            ]
        )
    }
}
extension CategoryLayout.Props {
    static var initial: CategoryLayout.Props {
        .init(title: "", image: .init())
    }
}
