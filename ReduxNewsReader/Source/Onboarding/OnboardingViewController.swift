//
//  OnboardingViewController.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 26.05.2021.
//

import LayoutKit

public class OnboardingViewController: UIViewController {
    public typealias Props = OnboardingTextLayout.Props
    
    private var props: Props = .initial
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Asset.Colors.lightGray.color
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let layout = VerticalEqualSpacingLayout(
            sublayouts: [
                OnboardingGridCategoryLayout(
                    props: .init(
                        shapito: Asset.shapito.image,
                        game: Asset.game.image,
                        history: Asset.history.image,
                        debriefing: Asset.debriefing.image
                    ),
                    viewReuseId: "onboarding.grid"
                ).insets(.top(view.safeAreaInsets.top)),
                SizeLayout(
                    minHeight: 280,
                    sublayout: PageLayout(
                        sublayout: OnboardingTextLayout(
                            props: props,
                            viewReuseId: "onboarding.content.text"
                        ).insets(.bottom(32 + view.safeAreaInsets.bottom)),
                        viewReuseId: "onboarding.content"
                    )
                )
            ],
            maxHeight: view.bounds.height
        )
        
        layout
            .arrangement(
                origin: .zero,
                width: view.bounds.width,
                height: view.bounds.height
            )
            .makeViews(in: view)
    }
    
    public func render(props: Props) {
        self.props = props
        view.setNeedsLayout()
    }
}
