//
//  RecognizeDetectorLayout.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 04.06.2021.
//

import LayoutKit

public final class RecognizeDetectorView: UIView {
    public enum Props {
        case general(Command)
        case long(Command)
    }

    private let tap = UITapGestureRecognizer()
    private let long = UILongPressGestureRecognizer()

    public init() {
        super.init(frame: .zero)
        tap.isEnabled = false
        long.isEnabled = false

        addGestureRecognizer(tap)
        addGestureRecognizer(long)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func render(props: Props) {

        tap.isEnabled = {
            switch props {
            case .general:
                return true
            case .long:
                return false
            }
        }()

        long.isEnabled = {
            switch props {
            case .long:
                return true
            case .general:
                return false
            }
        }()

        switch props {
        case .general(let onTap):
            tap.add(command: onTap)

        case .long(let onTap):
            long.add(command: onTap)
        }
    }
}

public final class RecognizeDetectorLayout: SizeLayout<RecognizeDetectorView> {
    
    public init(
        props: RecognizeDetectorView.Props,
        sublayout: Layout,
        viewReuseId: String) {
        super.init(
            viewReuseId: viewReuseId,
            sublayout: sublayout,
            config: { $0.render(props: props) }
        )
    }
}
