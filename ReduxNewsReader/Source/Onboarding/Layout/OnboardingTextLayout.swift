//
//  OnboardingTextLayout.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 25.05.2021.
//

import LayoutKit

public final class OnboardingTextLayout: StackLayout<UIView> {
    public struct Props {
        public let title: String
        public let subtitle: String
        public let onNext: Command
    }
    
    public init(props: Props, viewReuseId: String) {
        let insets = UIEdgeInsets.left(40).right(40)
        super.init(
            axis: .vertical,
            spacing: 16,
            distribution: .leading,
            sublayouts: [
                LabelLayout(
                    attributedText: .init(
                        string: props.title,
                        attributes: [
                            .font: UIFont.systemFont(ofSize: 24, weight: .semibold),
                            .paragraphStyle: {
                                let paragraph = NSMutableParagraphStyle()
                                paragraph.lineSpacing = 5
                                return paragraph
                            }(),
                            .foregroundColor: Asset.Colors.black.color
                        ]
                    ),
                    viewReuseId: "\(viewReuseId).title"
                ).insets(insets),
                LabelLayout(
                    attributedText: .init(
                        string: props.subtitle,
                        attributes: [
                            .font: UIFont.systemFont(ofSize: 14, weight: .regular),
                            .paragraphStyle: {
                                let paragraph = NSMutableParagraphStyle()
                                paragraph.lineSpacing = 5
                                return paragraph
                            }(),
                            .foregroundColor: Asset.Colors.darkBlue.color
                        ]
                    ),
                    viewReuseId: "\(viewReuseId).subtitle"
                ).insets(insets),
                SizeLayout<UIButton>(
                    height: 60,
                    viewReuseId: "\(viewReuseId).button",
                    config: { button in
                        button.layer.cornerRadius = 12
                        button.backgroundColor = Asset.Colors.blue.color
                        button.setAttributedTitle(
                            .init(
                                string: "NEXT",
                                attributes: [
                                    .font: UIFont.systemFont(ofSize: 16, weight: .regular),
                                    .foregroundColor: UIColor.white
                                ]
                            ),
                            for: .normal
                        )
                        button.setAttributedTitle(
                            .init(
                                string: "NEXT",
                                attributes: [
                                    .font: UIFont.systemFont(ofSize: 16, weight: .regular),
                                    .foregroundColor: UIColor.white.withAlphaComponent(0.3)
                                ]
                            ),
                            for: .highlighted
                        )
                        button.add(command: props.onNext, event: .touchUpInside)
                    }
                ).insets(.top(5).left(40).right(40))
            ]
        )
    }
}

extension OnboardingTextLayout.Props {
    public static var initial: OnboardingTextLayout.Props {
        .init(title: "", subtitle: "", onNext: .nop)
    }
}
