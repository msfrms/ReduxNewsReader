//
//  UIButtonExtensions.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 28.05.2021.
//

import UIKit

public extension UIButton {
    private struct AssociatedKeys {
        static var commandKey = "uikit_button_command_key"
    }

    private var command: Command? {
        get { objc_getAssociatedObject(self, &AssociatedKeys.commandKey) as? Command }

        set {
            guard let cmd = newValue else {
                return
            }
            objc_setAssociatedObject(
                self,
                &AssociatedKeys.commandKey,
                cmd,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }

    func add(command: Command, event: UIControl.Event) {
        removeTarget(self, action: #selector(handle), for: event)
        addTarget(self, action: #selector(handle), for: event)
        self.command = command
    }

    @objc private func handle() {
        command?.execute()
    }
}
