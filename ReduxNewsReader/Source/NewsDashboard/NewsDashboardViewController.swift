//
//  NewsDashboardViewController.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 28.05.2021.
//

import LayoutKit

public class NewsDashboardViewController: BaseViewController {
    public struct Props {
        public enum LatestNews {
            case inProgress
            case loaded(LatestNewsLayout.Props)
            case empty(CardEmptyLayout.Props)
        }
        public let header: String
        public let categories: NewsCategoryListView.Props
        public let latestNews: LatestNews?
    }
    
    private let scrollView = UIScrollView()
    private var props: Props = .initial
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Asset.Colors.white.color
        view.addSubview(scrollView)
        
        scrollView.pin(to: view.safeAreaLayoutGuide)
        scrollView.frame = view.bounds
        scrollView.showsVerticalScrollIndicator = false
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        render()
    }
    
    private func render() {
        let rootViewReuseId = "dashboard"
        
        let safeAreaInsets = view.safeAreaInsets
        
        scrollView.contentInset = .init(
            top: safeAreaInsets.top,
            left: 0,
            bottom: safeAreaInsets.bottom,
            right: 0
        )
        
        let latestNews: Layout? = props.latestNews.map {
            switch $0 {
            case .loaded(let props):
                return LatestNewsLayout(
                    props: props,
                    viewReuseId: "\(rootViewReuseId).latest.news.loaded"
                ).insets(.left(40).right(40))
                
            case .inProgress:
                return SizeLayout<LatestNewsLoadingView>(
                    width: view.bounds.width,
                    viewReuseId: "\(rootViewReuseId).latest.news.loading",
                    config: { _ in }
                )
                
            case .empty(let props):
                return CardEmptyLayout(
                    props: props,
                    viewReuseId: "\(rootViewReuseId).latest.news.empty"
                ).insets(.left(40).right(40))
            }
        }
        
        let main = StackLayout(
            axis: .vertical,
            spacing: 30,
            distribution: .leading,
            sublayouts: [
                LabelLayout(
                    attributedText: .init(
                        string: "Медуза.Новости",
                        attributes: [
                            .font: UIFont.systemFont(ofSize: 24, weight: .heavy),
                            .foregroundColor: Asset.Colors.black.color
                        ]
                    ),
                    viewReuseId: "\(rootViewReuseId).header"
                ).insets(.left(40)),
                SizeLayout<NewsCategoryListView>(
                    height: 273,
                    viewReuseId: "\(rootViewReuseId).news.categories",
                    config: { view in
                        view.render(props: self.props.categories)
                    }
                ),
                latestNews
            ].compactMap { $0 }
        )
        
        let arrangement = main.arrangement(
            origin: .zero,
            width: view.bounds.width
        )
        
        scrollView.contentSize = .init(width: 0, height: arrangement.frame.height)
        
        arrangement.makeViews(in: scrollView)
    }
    
    public func render(props: Props) {
        self.props = props
        guard isViewLoaded else {
            return
        }
        render()
    }
}

extension NewsDashboardViewController.Props {
    static var initial: NewsDashboardViewController.Props {
        .init(header: "", categories: .initial, latestNews: .none)
    }
}
