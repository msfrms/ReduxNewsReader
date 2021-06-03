//
//  BaseViewController.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 03.06.2021.
//

import UIKit

public class BaseViewController: UIViewController {

    public var deinitCommand: Command = .nop
    public var willDisAppear: CommandWith<UIViewController> = .nop
    public var didLoad: Command = .nop
    public override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }

    public override func viewDidLoad() {
        super.viewDidLoad()
        didLoad.execute()
    }
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        willDisAppear.execute(value: self)
    }

    deinit {
        deinitCommand.execute()
    }
}

