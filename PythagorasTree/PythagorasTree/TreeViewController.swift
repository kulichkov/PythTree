//
//  TreeViewController.swift
//  PythagorasTree
//
//  Created by Mikhail Kulichkov on 24/01/17.
//  Copyright © 2017 Mikhail Kulichkov. All rights reserved.
//

import UIKit

fileprivate enum Constants {
    static let segueSettingsView = "DisplaySettingsView"
}

extension UIView {
    func applyGradient(colors: [UIColor]) -> Void {
        self.applyGradient(colors: colors, locations: nil)
    }

    func applyGradient(colors: [UIColor], locations: [NSNumber]?) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colors.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
    }
}

class TreeViewController: UIViewController {

    @IBOutlet fileprivate weak var treeView: PythTreeView!
    var fillSquares: Bool = false {
        didSet {
            treeView.fillSquare = fillSquares
        }
    }
    var madeBySquares: Bool = true {
        didSet {
            treeView.madeBySquares = madeBySquares
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Adding PinchGestureRecognizer
        treeView.addGestureRecognizer(UIPinchGestureRecognizer(target: treeView, action: #selector(PythTreeView.scaleChanged)))
        // Adding PanGestureRecognizer
        treeView.addGestureRecognizer(UIPanGestureRecognizer(target: treeView, action: #selector(PythTreeView.originMove)))
        // Adding TapGestureRecognizer
        let doubleTapGestureRecognizer = UITapGestureRecognizer(target: treeView, action: #selector(PythTreeView.originReset))
        doubleTapGestureRecognizer.numberOfTapsRequired = 2
        doubleTapGestureRecognizer.numberOfTouchesRequired = 1
        treeView.addGestureRecognizer(doubleTapGestureRecognizer)
        // Adding RotationGestureRecognizer
        //treeView.addGestureRecognizer(UIRotationGestureRecognizer(target: treeView, action: #selector(PythTreeView.angleChanged)))
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //Move origin to center
        treeView.origin = CGPoint(x: treeView.bounds.midX, y: treeView.bounds.height - treeView.bounds.midY/4)

        //Gradient background
        let blue = UIColor(colorLiteralRed: 78/255.0, green: 208/255.0, blue: 255/255.0, alpha: 1.0)
        let colors = [blue, UIColor.white]
        self.view.applyGradient(colors: colors, locations: [0.0, 0.8])

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case Constants.segueSettingsView:
                (segue.destination as? SettingsViewController)?.treeViewController = self
            default:
                break
            }
        }
    }

}
