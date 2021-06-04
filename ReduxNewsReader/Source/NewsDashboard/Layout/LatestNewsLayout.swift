//
//  LatestNewsLayout.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 28.05.2021.
//

import LayoutKit
import SkeletonView

public final class LatestNewsLayout: StackLayout<UIView> {
    public struct Props {
        public let header: String
        public let more: Command
        public let news: [NewsLayout.Props]
    }
    
    public enum Styles {
        case forNormal
        case forLoading
    }
    
    public init(props: Props, viewReuseId: String, styles: Styles = .forNormal) {
        let titleColor = styles == .forNormal ? Asset.Colors.black.color : UIColor.clear
        let moreColor = styles == .forNormal ? Asset.Colors.blue.color : UIColor.clear
        
        let header = StackLayout(
            axis: .horizontal,
            distribution: .fillEqualSpacing,
            sublayouts: [
                LabelLayout(
                    attributedText: .init(
                        string: props.header,
                        attributes: [
                            .font: UIFont.systemFont(ofSize: 20, weight: .heavy),
                            .foregroundColor: titleColor
                        ]
                    ),
                    viewReuseId: "\(viewReuseId).header",
                    config: { $0.isSkeletonable = false }
                ),
                SizeLayout<UIButton>(
                    width: 44,
                    height: 20,
                    viewReuseId: "\(viewReuseId).more",
                    config: { view in
                        view.isSkeletonable = false
                        view.add(command: props.more, event: .touchUpInside)
                        view.setAttributedTitle(
                            .init(
                                string: "Все",
                                attributes: [
                                    .font: UIFont.systemFont(ofSize: 20, weight: .medium),
                                    .foregroundColor: moreColor
                                ]
                            ),
                            for: .normal
                        )
                        view.setAttributedTitle(
                            .init(
                                string: "Все",
                                attributes: [
                                    .font: UIFont.systemFont(ofSize: 20, weight: .medium),
                                    .foregroundColor: moreColor.withAlphaComponent(0.3)
                                ]
                            ),
                            for: .highlighted
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
                            sublayout: RecognizeDetectorLayout(
                                props: .general(news.onTap),
                                sublayout: NewsLayout(
                                    props: news,
                                    viewReuseId: "\(viewReuseId).news[\(index)]",
                                    styles: .normal
                                ),
                                viewReuseId: "\(viewReuseId).news[\(index)].tap"
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
