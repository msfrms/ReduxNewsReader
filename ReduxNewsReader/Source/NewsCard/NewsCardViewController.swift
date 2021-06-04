//
//  NewsDetailViewController.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 30.05.2021.
//

import LayoutKit

public class NewsCardViewController: BaseViewController {
    
    public enum Props {
        case inProgress
        case card(NewsCardLayout.Props)
        case empty(PlainEmptyLayout.Props)
    }
    
    private let scrollView = UIScrollView()
    private var props: Props = .initial
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        
        scrollView.pin(to: view.safeAreaLayoutGuide)
        scrollView.frame = view.bounds
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = Asset.Colors.lightGray.color
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        render()
    }
    
    private func render() {
        let rootViewReuseId = "news.card"
        
        scrollView.isHidden = {
            switch props {
            case .card:
                return false
            case .empty, .inProgress:
                return true
            }
        }()
        
        
        view.reuseView(by: "\(rootViewReuseId).empty")?.isHidden = {
            switch props {
            case .card, .inProgress:
                return true
            case .empty:
                return false
            }
        }()
        
        view.reuseView(by: "\(rootViewReuseId).loading")?.isHidden = {
            switch props {
            case .inProgress:
                return false
            case .empty, .card:
                return true
            }
        }()
        
        view.backgroundColor = {
            switch props {
            case .inProgress:
                return .white
            case .card, .empty:
                return Asset.Colors.lightGray.color
            }
        }()
        
        switch props {
        case .inProgress:
            let layout = SizeLayout<NewsCardLoadingView>(
                width: view.bounds.width,
                viewReuseId: "\(rootViewReuseId).loading",
                config: { _ in }
            ).insets(.top(view.safeAreaInsets.top + 10).left(10).right(10))
            layout
                .arrangement(
                    origin: .zero,
                    width: view.bounds.width,
                    height: view.bounds.height
                )
                .makeViews(in: view)

        case .card(let props):
            let main = NewsCardLayout(
                props: props,
                viewReuseId: "\(rootViewReuseId).card"
            )
            
            let arrangement = main.arrangement(
                origin: .zero,
                width: view.bounds.width
            )
            
            scrollView.contentSize = .init(width: 0, height: arrangement.frame.height)
            
            arrangement.makeViews(in: scrollView)
            
        case .empty(let props):
            let layout = PlainEmptyLayout(
                props: props,
                viewReuseId: "\(rootViewReuseId).empty"
            ).center(axis: .vertical)
            layout
                .arrangement(
                    origin: .zero,
                    width: view.bounds.width,
                    height: view.bounds.height
                )
                .makeViews(in: view)
        }
    }
    
    public func render(props: Props) {
        self.props = props
        guard isViewLoaded else {
            return
        }
        render()
    }
}

extension NewsCardViewController.Props {
    static var initial: NewsCardViewController.Props {
        .inProgress
    }
}
