//
//  PlainEmptyLayout.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 29.05.2021.
//

import LayoutKit

public final class PlainEmptyLayout: InsetLayout<UIView> {
    public struct Props {
        public let title: String
        public let description: String
        public let onRetry: Command
    }
    
    public init(props: Props, viewReuseId: String) {
        super.init(
            insets: .zero,
            viewReuseId: "\(viewReuseId).card.shadow",
            sublayout: StackLayout(
                axis: .vertical,
                spacing: 15,
                distribution: .center,
                sublayouts: [
                    SizeLayout<UIImageView>(
                        width: 170,
                        height: 143,
                        viewReuseId: "\(viewReuseId).icon",
                        config: { view in
                            view.image = Asset.noInternet.image
                        }
                    ),
                    LabelLayout(
                        attributedText: .init(
                            string: props.title,
                            attributes: [
                                .font: UIFont.systemFont(
                                    ofSize: 24,
                                    weight: .heavy
                                ),
                                .foregroundColor: Asset.Colors.black.color,
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
                    ).center(axis: .horizontal),
                    LabelLayout(
                        attributedText: .init(
                            string: props.description,
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
                        viewReuseId: "\(viewReuseId).description"
                    ).center(axis: .horizontal),
                    SizeLayout<UIButton>(
                        width: 140,
                        height: 40,
                        viewReuseId: "\(viewReuseId).retry",
                        config: { view in
                            view.setAttributedTitle(
                                .init(
                                    string: "Повторить",
                                    attributes: [
                                        .font: UIFont.systemFont(
                                            ofSize: 14,
                                            weight: .heavy
                                        ),
                                        .foregroundColor: Asset.Colors.blue.color
                                    ]
                                ),
                                for: .normal
                            )
                            view.setAttributedTitle(
                                .init(
                                    string: "Повторить",
                                    attributes: [
                                        .font: UIFont.systemFont(
                                            ofSize: 14,
                                            weight: .heavy
                                        ),
                                        .foregroundColor: Asset.Colors.blue.color.withAlphaComponent(0.3)
                                    ]
                                ),
                                for: .highlighted
                            )
                            view.add(command: props.onRetry, event: .touchUpInside)
                            view.layer.cornerRadius = 20
                            view.layer.borderWidth = 1
                            view.layer.borderColor = Asset.Colors.blue.color.cgColor
                        }
                    ).insets(.top(10))
                ]
            ),
            config: { _ in }
        )
    }
}
