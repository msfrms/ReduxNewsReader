//
//  UIGestureRecognizerExtensions.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 04.06.2021.
//

import Foundation

import UIKit

extension UIGestureRecognizer {
    
    private struct AssociatedKeys {
        static var commandKey = "uikit_gesture_recognizer_command_key"
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

    func add(command: Command) {
        removeTarget(self, action: #selector(handle))
        addTarget(self, action: #selector(handle))
        self.command = command
    }

    @objc private func handle() {
        command?.execute()
    }
}
