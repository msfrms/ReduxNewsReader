//
//  LatestNewsLayout.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 28.05.2021.
//

import LayoutKit

public final class LatestNewsLayout: StackLayout<UIView> {
    public struct Props {
        public let header: String
        public let more: Command
        public let news: [NewsLayout.Props]
    }
    
    public init(props: Props, viewReuseId: String) {
        let header = StackLayout(
            axis: .horizontal,
            distribution: .fillEqualSpacing,
            sublayouts: [
                LabelLayout(
                    attributedText: .init(
                        string: props.header,
                        attributes: [
                            .font: UIFont.systemFont(ofSize: 20, weight: .heavy),
                            .foregroundColor: Asset.Colors.black.color
                        ]
                    ),
                    viewReuseId: "\(viewReuseId).header"
                ),
                SizeLayout<UIButton>(
                    width: 44,
                    height: 20,
                    viewReuseId: "\(viewReuseId).more",
                    config: { view in
                        view.add(command: props.more, event: .touchUpInside)
                        view.setAttributedTitle(
                            .init(
                                string: "Все",
                                attributes: [
                                    .font: UIFont.systemFont(ofSize: 20, weight: .medium),
                                    .foregroundColor: Asset.Colors.blue.color
                                ]
                            ),
                            for: .normal
                        )
                    }
                )
            ]
        )
        
        super.init(
            axis: .vertical,
            spacing: 24,
            distribution: .leading,
            viewReuseId: viewReuseId,
            sublayouts: [
                header,
                StackLayout(
                    axis: .vertical,
                    spacing: 10,
                    distribution: .leading,
                    sublayouts: props.news.mapWithIndex { news, index in
                        ShadowLayout(
                            sublayout: NewsLayout(
                                props: news,
                                viewReuseId: "\(viewReuseId).news[\(index)]"
                            ),
                            viewReuseId: "\(viewReuseId).news[\(index)].shadow",
                            styles: .shadow(.blue)
                        )
                    }
                )
            ]
        )
    }
}
