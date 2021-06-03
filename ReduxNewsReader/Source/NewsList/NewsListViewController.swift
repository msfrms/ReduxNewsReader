//
//  NewsListViewController.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 29.05.2021.
//

import LayoutKit

extension UICollectionViewLayout {

    static var vertical: UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()

        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical

        return layout
    }
}

public final class NewsListViewController: BaseViewController {

    public enum Props {

        public struct List {
            public let items: [NewsLayout.Props]
            public let onFirstPage: Command
            public let onNextPage: Command
            
        }
        case inProgress
        case empty(PlainEmptyLayout.Props)
        case list(List)
    }
    
    private enum Constants {
        // как только скролим к концу контента то бросаем запрос за новой порцией данных
        static let batchingFactor: CGFloat = 0.65
        static let newsReuseId = "NewsCollectionViewCell"
    }
    
    private var props: Props = .initial
    private var items: [NewsLayout.Props] = []
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .vertical)
    private let refresh = UIRefreshControl()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = true
        collectionView.register(
            NewsCollectionViewCell.self,
            forCellWithReuseIdentifier: Constants.newsReuseId
        )
        collectionView.contentInset = .top(10)
        
        view.addSubview(collectionView)

        refresh.addTarget(self, action: #selector(onRefresh), for: .valueChanged)

        collectionView.pin(to: view)
        collectionView.addSubview(refresh)
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        render()
    }
    
    @objc private func onRefresh() {
        props.list?.onFirstPage.execute()
    }
    
    private func render() {
        let rootViewReuseId = "root"
        
        view.backgroundColor = {
            switch props {
            case .inProgress:
                return .white
            case .empty, .list:
                return Asset.Colors.lightGray.color
            }
        }()
        
        collectionView.isHidden = {
            switch props {
            case .list:
                return false
            case .empty, .inProgress:
                return true
            }
        }()
        
        view.reuseView(by: "\(rootViewReuseId).loading")?.isHidden = {
            switch props {
            case .empty, .list:
                return true
            case .inProgress:
                return false
            }
        }()
        
        view.reuseView(by: "\(rootViewReuseId).empty")?.isHidden = {
            switch props {
            case .empty:
                return false
            case .inProgress, .list:
                return true
            }
        }()
        
        let layout: Layout = {
            switch props {
            
            case .inProgress:
                return SizeLayout<NewsListLoadingView>(
                    width: view.bounds.width,
                    viewReuseId: "\(rootViewReuseId).loading",
                    config: { _ in }
                ).insets(.top(view.safeAreaInsets.top + 10).left(10).right(10))
                
            case .empty(let props):
                return PlainEmptyLayout(
                    props: props,
                    viewReuseId: "\(rootViewReuseId).empty"
                ).center(axis: .vertical)
                
            case .list:
                return SizeLayout()
            }
        }()
        
        layout.arrangement(
            origin: .zero,
            width: view.bounds.width,
            height: view.bounds.height
        ).makeViews(in: view)
        
        if refresh.isRefreshing && props.list != nil {
            refresh.endRefreshing()
        }
        
        collectionView.reloadData()
    }
    
    public func render(props: Props) {
        self.props = props
        self.items = props.list?.items ?? []
        guard isViewLoaded else {
            return
        }
        render()
    }
}

extension NewsListViewController: UIScrollViewDelegate {

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollFactor = scrollView.contentOffset.y / scrollView.contentSize.height
        
        if scrollFactor >= Constants.batchingFactor {
            props.list?.onNextPage.execute()
        }
    }
}

extension NewsListViewController: UICollectionViewDataSource {

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.newsReuseId,
            for: indexPath
        ) as? NewsCollectionViewCell else {
                fatalError()
        }
        
        guard items.indices.contains(indexPath.row) else {
            fatalError()
        }
        
        let props = items[indexPath.row]
        
        cell.render(props: props)
        
        return cell
    }
}

extension NewsListViewController: UICollectionViewDelegate {

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard items.indices.contains(indexPath.row) else {
            return
        }
        items[indexPath.row].onTap.execute()
    }
}

extension NewsListViewController: UICollectionViewDelegateFlowLayout {

    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard items.indices.contains(indexPath.row) else {
            fatalError()
        }
        
        let props = items[indexPath.row]
        
        return .init(
            width: collectionView.bounds.width,
            height: NewsCollectionViewCell.cellHeight(
                props: props,
                forWidth: collectionView.bounds.width
            )
        )
    }
}

extension NewsListViewController.Props {

    static var initial: NewsListViewController.Props {
        .list(.init(items: [], onFirstPage: .nop, onNextPage: .nop))
    }
    
    var list: NewsListViewController.Props.List? {
        switch self {
        case .list(let list):
            return list
        default:
            return nil
        }
    }
}
