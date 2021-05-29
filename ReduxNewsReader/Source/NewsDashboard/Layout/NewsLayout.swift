//
//  NewsLayout.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 28.05.2021.
//

import LayoutKit
import Kingfisher

public final class NewsLayout: StackLayout<UIView> {
    
    public struct Props {
        public let title: String
        public let subtitle: String
        public let coverUrl: URL?
        public let onTap: Command
    }
    
    public init(props: Props, viewReuseId: String) {
        
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
                    viewReuseId: "\(viewReuseId).title"
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
                    numberOfLines: 2,
                    viewReuseId: "\(viewReuseId).subtitle"
                )
            ]
        )
        
        super.init(
            axis: .horizontal,
            spacing: 23,
            distribution: .leading,
            viewReuseId: viewReuseId,
            sublayouts: [
                SizeLayout<UIImageView>(
                    width: 92,
                    height: 92,
                    viewReuseId: "\(viewReuseId).icon",
                    config: { view in
                        view.kf.setImage(with: props.coverUrl)
                        view.layer.cornerRadius = 16
                        view.clipsToBounds = true
                        view.backgroundColor = Asset.Colors.darkGray.color
                    }
                ),
                texts.center(axis: .vertical)
            ],
            config: { view in
                view.layer.cornerRadius = 16
                view.backgroundColor = .white
            }
        )
    }
}
