//
//  NewsCollectionViewCell.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 30.05.2021.
//

import LayoutKit

public class NewsCollectionViewCell: UICollectionViewCell {

    public func render(props: NewsLayout.Props) {
        let layout = NewsLayout(props: props, viewReuseId: "cell")
            .insets(.left(10).right(10))
        layout
            .arrangement(
                origin: .zero,
                width: contentView.bounds.width,
                height: contentView.bounds.height
            )
            .makeViews(in: contentView)
    }
    
    public static func cellHeight(props: NewsLayout.Props, forWidth: CGFloat) -> CGFloat {
        let layout = NewsLayout(props: props, viewReuseId: "cell")
            .insets(.left(10).right(10))
        return layout
            .arrangement(
                origin: .zero,
                width: forWidth
            )
            .frame
            .height
    }
}
