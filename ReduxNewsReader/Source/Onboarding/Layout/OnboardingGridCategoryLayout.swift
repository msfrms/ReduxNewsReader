//
//  OnboardingGridCategoryLayout.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 26.05.2021.
//

import LayoutKit

public final class OnboardingGridCategoryLayout: InsetLayout<UIView> {
    public struct Props {
        public typealias Item = UIImage
        
        public let shapito: Item
        public let game: Item
        public let history: Item
        public let debriefing: Item
    }
    
    public init(props: Props, viewReuseId: String) {
        let shapitoLayout = ShadowLayout(
            sublayout: SizeLayout<UIImageView>(
                width: 92,
                height: 157,
                viewReuseId: "\(viewReuseId).shapito",
                config: { view in
                    view.image = props.shapito
                }
            ),
            viewReuseId: "\(viewReuseId).shapito.shadow"
        )
        let gameLayout = ShadowLayout(
            sublayout: SizeLayout<UIImageView>(
                height: 157,
                viewReuseId: "\(viewReuseId).game",
                config: { view in
                    view.image = props.game
                }
            ),
            viewReuseId: "\(viewReuseId).game.shadow"
        )
        let historyLayout = ShadowLayout(
            sublayout: SizeLayout<UIImageView>(
                height: 157,
                viewReuseId: "\(viewReuseId).history",
                config: { view in
                    view.image = props.history
                }
            ),
            viewReuseId: "\(viewReuseId).history.shadow"
        )
        let debriefingLayout = ShadowLayout(
            sublayout: SizeLayout<UIImageView>(
                width: 92,
                height: 157,
                viewReuseId: "\(viewReuseId).debriefing",
                config: { view in
                    view.image = props.debriefing
                }
            ),
            viewReuseId: "\(viewReuseId).debriefing.shadow"
        )
        super.init(
            insets: .left(40).right(40),
            sublayout: StackLayout(
                axis: .vertical,
                spacing: 16,
                sublayouts: [
                    StackLayout(
                        axis: .horizontal,
                        spacing: 12,
                        sublayouts: [
                            shapitoLayout,
                            gameLayout
                        ]
                    ),
                    StackLayout(
                        axis: .horizontal,
                        spacing: 12,
                        sublayouts: [
                            historyLayout,
                            debriefingLayout
                        ]
                    )
                ]
            )
        )
    }
}
