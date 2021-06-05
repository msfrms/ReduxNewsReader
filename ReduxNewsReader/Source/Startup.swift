//
//  Startup.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 05.06.2021.
//

import UIKit

public class Startup {

    public func create(with store: Store<AppState>) -> UIViewController {
        let isFirstLaunch = UserDefaults.standard.string(forKey: "isFirstLaunch")
        if isFirstLaunch == nil {
            UserDefaults.standard.setValue("first-launch", forKey: "isFirstLaunch")
            UserDefaults.standard.synchronize()
            let onboardingViewcontroller = OnboardingViewController()
            onboardingViewcontroller.render(
                props: .init(
                    title: "Медуза.Новости",
                    subtitle: "Читай медуза.новости\nбудь в курсе событий в нашем не простом мире",
                    onNext: Command { [weak onboardingViewcontroller] in
                        guard let view = onboardingViewcontroller else {
                            return
                        }
                        let dashboardViewController = NewsDashboardViewController()
                        NewsDashboardConnector.connect(
                            store: store,
                            to: dashboardViewController
                        )
                        
                        let navigationViewController = UINavigationController(
                            rootViewController: dashboardViewController
                        )
                        
                        navigationViewController.modalPresentationStyle = .overFullScreen
                        view.present(
                            navigationViewController,
                            animated: true,
                            completion: nil
                        )
                    }
                )
            )
            return onboardingViewcontroller
        }
        else {
            let dashboardViewController = NewsDashboardViewController()
            NewsDashboardConnector.connect(store: store, to: dashboardViewController)
            return UINavigationController(rootViewController: dashboardViewController)
        }
    }
}
