//
//  CardEmptyLayout.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 29.05.2021.
//

import LayoutKit

public final class CardEmptyLayout: InsetLayout<UIView> {
    public struct Props {
        public let title: String
        public let onRetry: Command
    }
    
    public init(props: Props, viewReuseId: String) {
        super.init(
            insets: .zero,
            sublayout: ShadowLayout(
                sublayout: StackLayout(
                    axis: .vertical,
                    spacing: 15,
                    distribution: .center,
                    viewReuseId: "\(viewReuseId)",
                    sublayouts: [
                        SizeLayout<UIImageView>(
                            width: 186,
                            height: 145,
                            viewReuseId: "\(viewReuseId).icon",
                            config: { view in
                                view.image = Asset.poorConnection.image
                            }
                        ),
                        LabelLayout(
                            attributedText: .init(
                                string: props.title,
                                attributes: [
                                    .font: UIFont.systemFont(
                                        ofSize: 18,
                                        weight: .medium
                                    ),
                                    .foregroundColor: Asset.Colors.darkBlue.color,
                                    .paragraphStyle: {
                                        let paragraph = NSMutableParagraphStyle()
                                        paragraph.alignment = .center
                                        paragraph.lineBreakMode = .byWordWrapping
                                        return paragraph
                                    }()
                                ]
                            ),
                            numberOfLines: 2,
                            viewReuseId: "\(viewReuseId).title"
                        ),
                        SizeLayout<UIButton>(
                            width: 120,
                            height: 20,
                            viewReuseId: "\(viewReuseId).retry",
                            config: { view in
                                view.setAttributedTitle(
                                    .init(
                                        string: "Повторить".uppercased(),
                                        attributes: [
                                            .font: UIFont.systemFont(
                                                ofSize: 18,
                                                weight: .medium
                                            ),
                                            .foregroundColor: Asset.Colors.blue.color
                                        ]
                                    ),
                                    for: .normal
                                )
                                view.setAttributedTitle(
                                    .init(
                                        string: "Повторить".uppercased(),
                                        attributes: [
                                            .font: UIFont.systemFont(
                                                ofSize: 18,
                                                weight: .medium
                                            ),
                                            .foregroundColor: Asset.Colors.blue.color.withAlphaComponent(0.3)
                                        ]
                                    ),
                                    for: .highlighted
                                )
                                view.add(command: props.onRetry, event: .touchUpInside)
                            }
                        )
                    ],
                    config: { view in
                        view.backgroundColor = .white
                        view.layer.cornerRadius = 16
                    }
                ).insets(.init(40)),
                viewReuseId: "\(viewReuseId).card.shadow",
                styles: .shadow(.card)
            )
        )
    }
}
