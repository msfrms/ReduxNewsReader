//
//  NewsDetailLayout.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 30.05.2021.
//

import LayoutKit
import Kingfisher
import SkeletonView

public class NewsCardLayout: StackLayout<UIView> {

    public struct Props {
        public let coverUrl: URL?
        public let title: String
        public let subtitle: String
        public let source: String
        public let date: String
        public let content: String
    }
    
    public enum Styles {
        case forLoading
        case forPresent
    }
    
    public init(props: Props, viewReuseId: String, styles: Styles = .forPresent) {
        
        let sourceLayout = StackLayout(
            axis: .vertical,
            spacing: 5,
            distribution: .leading,
            sublayouts: [
                LabelLayout(
                    attributedText: .init(
                        string: "Источник: \(props.source)",
                        attributes: {
                            switch styles {
                            case .forPresent:
                                return [
                                    .font: UIFont.systemFont(ofSize: 14, weight: .medium),
                                    .foregroundColor: Asset.Colors.black.color,
                                    .underlineStyle: NSUnderlineStyle.single.rawValue,
                                    .underlineColor: Asset.Colors.black.color,
                                ]
                            case .forLoading:
                                return [
                                    .font: UIFont.systemFont(ofSize: 14, weight: .medium),
                                    .foregroundColor: Asset.Colors.black.color,
                                ]
                            }
                        }()
                    ),
                    viewReuseId: "\(viewReuseId).source.title",
                    config: { $0.isSkeletonable = true }
                ),
                LabelLayout(
                    attributedText: .init(
                        string: props.date,
                        attributes: [
                            .font: UIFont.systemFont(ofSize: 14, weight: .medium),
                            .foregroundColor: Asset.Colors.black.color
                        ]
                    ),
                    viewReuseId: "\(viewReuseId).source.date",
                    config: { $0.isSkeletonable = true }
                )
            ]
        )
        
        let coverLayout: Layout? = props.coverUrl.map { url in
            SizeLayout<UIImageView>(
                height: 220,
                config: { view in
                    view.isSkeletonable = true
                    view.contentMode = .scaleAspectFill
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
                        viewReuseId: "\(viewReuseId).subtitle",
                        config: { $0.isSkeletonable = true }
                    ).insets(.top(16).left(40).right(40)),
                    LabelLayout(
                        attributedText: props.content.htmlAsAttributedString ?? .init(),
                        viewReuseId: "\(viewReuseId).body",
                        config: { $0.isSkeletonable = true }
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
                            viewReuseId: "\(viewReuseId).title",
                            config: { $0.isSkeletonable = true }
                        ),
                        sourceLayout
                    ]
                ).insets(.left(40).right(40)),
                page.insets(.bottom(10))
            ]
        )
    }
}
