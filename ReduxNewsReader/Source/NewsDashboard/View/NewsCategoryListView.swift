//
//  NewsCategoryListView.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 28.05.2021.
//

import UIKit

private extension UICollectionViewLayout {
    static var horizontal: UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: 236, height: 273)
        layout.minimumLineSpacing = 22
        return layout
    }
}

public class NewsCategoryListView: UIView {
    
    private enum Constants {
        static let categoryCellReuseIdentifier = "categoryCellReuseIdentifier"
    }
    
    public struct Props {
        public let items: [CategoryLayout.Props]
    }
    
    private let collectionView: UICollectionView
    private var props: Props = .initial
    
    init() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: .horizontal)

        super.init(frame: .zero)

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            CategoryCollectionViewCell.self,
            forCellWithReuseIdentifier: Constants.categoryCellReuseIdentifier
        )
        collectionView.backgroundColor = .clear
        collectionView.decelerationRate = .fast
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        addSubview(collectionView)
        
        backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = bounds
    }
    
    public func render(props: Props) {
        self.props = props
        collectionView.reloadData()
    }
}

extension NewsCategoryListView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        props.items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Constants.categoryCellReuseIdentifier,
                for: indexPath
        ) as? CategoryCollectionViewCell else {
                fatalError()
        }
        guard props.items.indices.contains(indexPath.row) else {
            fatalError()
        }
        
        let props = props.items[indexPath.row]
        cell.render(props: props)
        return cell
    }
    
}

extension NewsCategoryListView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard props.items.indices.contains(indexPath.row) else {
            fatalError()
        }
        props.items[indexPath.row].onTap.execute()
    }
}

extension NewsCategoryListView.Props {
    static var initial: NewsCategoryListView.Props {
        .init(items: [])
    }
}
