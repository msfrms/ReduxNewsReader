//
//  NewsDetailLayout.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 30.05.2021.
//

import LayoutKit
import Kingfisher

public class NewsDetailLayout: StackLayout<UIView> {

    public struct Props {
        public let coverUrl: URL?
        public let title: String
        public let subtitle: String
        public let source: String
        public let date: String
        public let content: String
    }
    
    public init(props: Props, viewReuseId: String) {
        
        let sourceLayout = StackLayout(
            axis: .vertical,
            spacing: 5,
            distribution: .leading,
            sublayouts: [
                LabelLayout(
                    attributedText: .init(
                        string: "Источник: \(props.source)",
                        attributes: [
                            .font: UIFont.systemFont(ofSize: 14, weight: .medium),
                            .foregroundColor: Asset.Colors.black.color,
                            .underlineStyle: NSUnderlineStyle.single.rawValue,
                            .underlineColor: Asset.Colors.black.color,
                        ]
                    ),
                    viewReuseId: "\(viewReuseId).source.title"
                ),
                LabelLayout(
                    attributedText: .init(
                        string: props.date,
                        attributes: [
                            .font: UIFont.systemFont(ofSize: 14, weight: .medium),
                            .foregroundColor: Asset.Colors.black.color,
                            .underlineStyle: NSUnderlineStyle.single.rawValue,
                            .underlineColor: Asset.Colors.black.color,
                        ]
                    ),
                    viewReuseId: "\(viewReuseId).source.date"
                )
            ]
        )
        
        let coverLayout: Layout? = props.coverUrl.map { url in
            SizeLayout<UIImageView>(
                height: 220,
                config: { view in
                    view.kf.setImage(with: url)
                    view.backgroundColor = Asset.Colors.darkGray.color
                    view.layer.masksToBounds = true
                    view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
                    view.layer.cornerRadius = 28
                }
            ).insets(.top(-28))
        }
        
        let page = PageLayout(
            sublayout: StackLayout(
                axis: .vertical,
                spacing: 16,
                sublayouts: [
                    coverLayout,
                    LabelLayout(
                        attributedText: .init(
                            string: props.title,
                            attributes: [
                                .font: UIFont.systemFont(ofSize: 18, weight: .heavy),
                                .foregroundColor: Asset.Colors.black.color
                            ]
                        ),
                        viewReuseId: "\(viewReuseId).subtitle"
                    ).insets(.top(16).left(40).right(40)),
                    LabelLayout(
                        attributedText: props.content.htmlAsAttributedString ?? .init(),
                        viewReuseId: "\(viewReuseId).body"
                    ).insets(.left(40).right(40)),
                    
                ]
                .compactMap { $0 }
            ),
            viewReuseId: "\(viewReuseId).content"
        )
        
        super.init(
            axis: .vertical,
            spacing: 30,
            distribution: .leading,
            sublayouts: [
                StackLayout(
                    axis: .vertical,
                    spacing: 30,
                    distribution: .leading,
                    sublayouts: [
                        LabelLayout(
                            attributedText: .init(
                                string: props.title,
                                attributes: [
                                    .font: UIFont.systemFont(ofSize: 24, weight: .heavy),
                                    .foregroundColor: Asset.Colors.black.color
                                ]
                            ),
                            viewReuseId: "\(viewReuseId).title"
                        ),
                        sourceLayout
                    ]
                ).insets(.left(40).right(40)),
                page
            ]
        )
    }
}
