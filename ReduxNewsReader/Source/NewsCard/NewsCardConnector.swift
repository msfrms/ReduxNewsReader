//
//  NewsCardConnector.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 04.06.2021.
//

import UIKit

public enum NewsCardConnector {
    
    public static func openCardBy(
        newsId: NewsCard.Id,
        store: Store<AppState>,
        fromViewController: UIViewController) -> Command {
        Command {
            let cardViewController = NewsCardViewController()
            connect(store: store, to: cardViewController, newsId: newsId)
            fromViewController.navigationController?.pushViewController(
                cardViewController,
                animated: true
            )
        }.observe(queue: .main)
    }
    
    public static func connect(
        store: Store<AppState>,
        to view: NewsCardViewController,
        newsId: NewsCard.Id) {
        
        let newsLoad = Command {
            store.dispatch(action: NewsCardAction.start(newsId))
        }
        
        view.didLoad = newsLoad
        
        let unsubscribe = store.subscribe(command: CommandWith<AppState> { [weak view] state in

            guard let view = view else {
                return
            }

            guard let newState = state.newsCard.byId[newsId],
                  let card = state.newsCardAll.byId[newsId] else {
                view.render(props: .inProgress)
                return
            }
            
            switch newState.status {
            case .inProgress, .none:
                view.render(props: .inProgress)

            case .failed:
                view.render(
                    props: .empty(
                        .init(
                            title: "Упс, что то пошло не так",
                            description: "Возможно у вас нет интернета",
                            onRetry: newsLoad
                        )
                    )
                )

            case .success:
                view.render(
                    props: .card(
                        .init(
                            coverUrl: card.coverUrl,
                            title: card.title,
                            subtitle: card.subtitle,
                            source: card.source,
                            date: {
                                let formatter = DateFormatter()
                                formatter.dateFormat = "dd.MM.yyyy"
                                return formatter.string(from: card.date)
                            }(),
                            content: card.body
                        )
                    )
                )
            }
        }.observe(queue: .main))
        
        view.deinitCommand = unsubscribe
    }
}
