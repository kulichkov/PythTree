//
//  RootViewController.swift
//  PythagorasTree
//
//  Created by Mikhail Kulichkov on 24/01/17.
//  Copyright © 2017 Mikhail Kulichkov. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    @IBOutlet weak var pythTreeViewHeight: NSLayoutConstraint!

    fileprivate enum Constants {
        static let segueSettingsView = "SegueSettingsView"
        static let segueTreeView = "SegueTreeView"
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Make square of pythTreeView
        pythTreeViewHeight.constant = view.frame.width
    }
}
