//
//  CategoryCollectionViewCell.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 28.05.2021.
//

import UIKit

public class CategoryCollectionViewCell: UICollectionViewCell {
    
    public func render(props: CategoryLayout.Props) {
        let layout = CategoryLayout(
            props: props,
            viewReuseId: "cell"
        )
        
        layout
            .arrangement(
                origin: .zero,
                width: contentView.bounds.width,
                height: contentView.bounds.height
            )
            .makeViews(in: contentView)
    }
}
