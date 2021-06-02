//
//  NewsCardLoadingView.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 02.06.2021.
//

import LayoutKit
import SkeletonView

public final class NewsCardLoadingView: UIView {
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        let rootViewReuseId = "news.card.loading"
        
        let layout = NewsCardLayout(
            props: .init(
                coverUrl: URL(string: "https://www.google.com"),
                title: "Four Things Every Woman Needs To Know",
                subtitle: "A man’s sexuality is never your mind responsibility.",
                source: "The New York Times",
                date: "11:47, 28 мая 2021",
                content: """
                    This one got an incredible amount of backlash the last time I said it, so I’m going to say it again: a man’s sexuality is never, ever your responsibility, under any circumstances. Whether it’s the fifth date or your twentieth year of marriage, the correct determining factor for whether or not you have sex with your partner isn’t whether you ought to “take care of him” or “put out” because it’s been a while or he’s really horny — the correct determining factor for whether or not you have sex is whether or not you want to have sex.
                    """
            ),
            viewReuseId: "\(rootViewReuseId).card",
            styles: .forLoading
        )
        
        let arrangement = layout.arrangement(
            origin: .zero,
            width: bounds.width,
            height: bounds.height
        )
        
        arrangement.makeViews(in: self)
        
        backgroundColor = .white

        
        recursiveShowAnimatedSkeleton(view: self)
    }
}
