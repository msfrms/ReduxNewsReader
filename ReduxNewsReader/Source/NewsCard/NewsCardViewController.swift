//
//  NewsDetailViewController.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 30.05.2021.
//

import UIKit

public class NewsCardViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        
        scrollView.pin(to: view.safeAreaLayoutGuide)
        scrollView.frame = view.bounds
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = Asset.Colors.lightGray.color
    }

    public func render(props: NewsCardLayout.Props) {
        
        let main = NewsCardLayout(
            props: props,
            viewReuseId: "news.detail"
        )
        
        let arrangement = main.arrangement(
            origin: .zero,
            width: view.bounds.width
        )
        
        scrollView.contentSize = .init(width: 0, height: arrangement.frame.height)
        
        arrangement.makeViews(in: scrollView)
    }
}
