//
//  NewsListLoadingView.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 29.05.2021.
//

import LayoutKit
import SkeletonView

public final class NewsListLoadingView: UIView {

    public override func layoutSubviews() {
        super.layoutSubviews()
        
        let rootViewReuseId = "news.list.loading"
        let news: [NewsLayout.Props] = [
            .init(
                title: "BIG DATA",
                subtitle: "Why Big Data Needs Thick Data?",
                coverUrl: nil,
                onTap: .nop
            ),
            .init(
                title: "UX DESIGN",
                subtitle: "Step design sprint for UX beginner",
                coverUrl: nil,
                onTap: .nop
            ),
            .init(
                title: "BIG DATA",
                subtitle: "Why Big Data Needs Thick Data?",
                coverUrl: nil,
                onTap: .nop
            ),
            .init(
                title: "UX DESIGN",
                subtitle: "Step design sprint for UX beginner",
                coverUrl: nil,
                onTap: .nop
            ),
            .init(
                title: "BIG DATA",
                subtitle: "Why Big Data Needs Thick Data?",
                coverUrl: nil,
                onTap: .nop
            )
        ]
        
        let layout = StackLayout(
            axis: .vertical,
            spacing: 10,
            distribution: .leading,
            sublayouts: news.mapWithIndex { news, index in
                NewsLayout(props: news, viewReuseId: "\(rootViewReuseId).news[\(index)]")
            }
        )
        
        let arrangement = layout.arrangement(
            origin: .zero,
            width: bounds.width
        )
        
        arrangement.makeViews(in: self)
        
        frame = .init(
            origin: frame.origin,
            size: .init(width: bounds.width, height: arrangement.frame.height)
        )
        
        recursiveShowAnimatedSkeleton(view: self)
    }
}
