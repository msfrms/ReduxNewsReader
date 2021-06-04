//
//  LatestNewsLoadingView.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 29.05.2021.
//

import SkeletonView

public final class LatestNewsLoadingView: UIView {
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = LatestNewsLayout(
            props: .init(
                header: "Последние новости",
                more: .nop,
                news: [
                    .init(
                        title: "BIG DATA",
                        subtitle: "Whx Bi Data Needs Thick Data?",
                        coverUrl: nil,
                        onTap: .nop
                    ),
                    .init(
                        title: "UX DESIGN",
                        subtitle: "Stex desinx sxrint for UX bexinner",
                        coverUrl: nil,
                        onTap: .nop
                    ),
                ]),
            viewReuseId: "latest.news.loading"
        ).insets(.left(10).right(10))
        
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
