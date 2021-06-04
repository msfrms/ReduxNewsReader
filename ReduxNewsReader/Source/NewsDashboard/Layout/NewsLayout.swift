//
//  NewsLayout.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 28.05.2021.
//

import LayoutKit
import Kingfisher
import SkeletonView

public final class NewsLayout: StackLayout<UIView> {
    
    public struct Props {
        public let title: String
        public let subtitle: String
        public let coverUrl: URL?
        public let onTap: Command
    }
    
    public enum Styles {
        case normal
        case loading
    }
    
    public init(props: Props, viewReuseId: String, styles: Styles = .normal) {
        
        let texts = StackLayout(
            axis: .vertical,
            spacing: 5,
            distribution: .leading,
            sublayouts: [
                LabelLayout(
                    attributedText: .init(
                        string: props.title.uppercased(),
                        attributes: [
                            .font: UIFont.systemFont(ofSize: 14, weight: .heavy),
                            .foregroundColor: Asset.Colors.blue.color
                        ]
                    ),
                    numberOfLines: 1,
                    viewReuseId: "\(viewReuseId).title",
                    config: { $0.isSkeletonable = true }
                ),
                LabelLayout(
                    attributedText: .init(
                        string: props.subtitle,
                        attributes: [
                            .font: UIFont.systemFont(ofSize: 14, weight: .medium),
                            .foregroundColor: Asset.Colors.black.color,
                            .paragraphStyle: {
                                let paragraph = NSMutableParagraphStyle()
                                paragraph.alignment = .left
                                paragraph.lineBreakMode = .byWordWrapping
                                return paragraph
                            }()
                        ]
                    ),
                    numberOfLines: styles == .normal ? 2 : 1,
                    viewReuseId: "\(viewReuseId).subtitle",
                    config: { $0.isSkeletonable = true }
                )
            ]
        )
        
        super.init(
            axis: .horizontal,
            spacing: 10,
            distribution: .leading,
            viewReuseId: viewReuseId,
            sublayouts: [
                SizeLayout<UIImageView>(
                    width: 92,
                    height: 92,
                    viewReuseId: "\(viewReuseId).icon",
                    config: { view in
                        view.isSkeletonable = true
                        view.kf.setImage(with: props.coverUrl)
                        view.contentMode = .scaleAspectFill
                        view.layer.cornerRadius = 16
                        view.clipsToBounds = true
                        view.backgroundColor = Asset.Colors.darkGray.color
                    }
                ),
                texts.center(axis: .vertical).insets(.left(10))
            ],
            config: { view in
                view.isSkeletonable = true
                view.layer.cornerRadius = 16
                view.backgroundColor = .white
            }
        )
    }
}
