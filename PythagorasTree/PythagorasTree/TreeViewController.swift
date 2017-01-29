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

    @IBOutlet weak var background: UIView!
    @IBOutlet fileprivate weak var treeView: PythTreeView!
    let gradientLayer = CAGradientLayer()
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
    var lineWidth: CGFloat = 1.0 {
        didSet {
            treeView.lineWidth = lineWidth
        }
    }
    var startLength: CGFloat = 40.0 {
        didSet {
            treeView.startLength = startLength
        }
    }
    var endLength: CGFloat = 5.0 {
        didSet {
            treeView.endLength = endLength
        }
    }
    var addedAngle: CGFloat = 0.0 {
        didSet {
            treeView.addedAngle = addedAngle
        }
    }
    var lengthChangeColor: CGFloat = 15.0 {
        didSet {
            treeView.lengthChangeColor = lengthChangeColor
        }
    }
    var leafColor: UIColor = UIColor(red: 64/255, green: 175/255, blue: 40/255, alpha: 1.0) {
        didSet {
            treeView.leafColor = leafColor
        }
    }
    var branchColor: UIColor = UIColor(red: 110/255, green: 50/255, blue: 40/255, alpha: 1.0) {
        didSet {
            treeView.branchColor = branchColor
        }
    }

    var backgroundColor: UIColor = UIColor(colorLiteralRed: 30/255.0, green: 150/255.0, blue: 255/255.0, alpha: 1.0) {
        didSet {
            let colors = [backgroundColor, UIColor.white]
            setUpGradientLayer(colors: colors, locations: [0.0, 0.8])
        }
    }

    func setUpGradientLayer(colors: [UIColor], locations: [NSNumber]?) -> Void {
        gradientLayer.frame = background.bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.locations = locations
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
//        let colors = [backgroundColor, UIColor.white]
//        view.applyGradient(colors: colors, locations: [0.0, 0.5])
        let colors = [backgroundColor, UIColor.white]
        setUpGradientLayer(colors: colors, locations: [0.0, 0.8])
        background.layer.insertSublayer(gradientLayer, at: 0)

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
