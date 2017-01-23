//
//  PythViewController.swift
//  PythagorasTree
//
//  Created by Mikhail Kulichkov on 12/01/17.
//  Copyright © 2017 Mikhail Kulichkov. All rights reserved.
//

import UIKit

extension CGFloat {
    func formatted(format: String) -> String {
        return String(format: "%\(format)f", self)
    }
}

fileprivate enum Constants {
    static let segmentIndexForLines = 1
    static let scaleZero: CGFloat = 0
    static let scaleDefault: CGFloat = 1
    static let angleTextFormat = ".3"
}

class PythViewController: UIViewController {
    @IBOutlet weak var pythView: PythTreeView!
    fileprivate var snapshot: UIView?
    @IBOutlet weak var angle: UILabel!
    @IBAction func changeTreeType(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case Constants.segmentIndexForLines:
            pythView.madeBySquares = false
        default:
            pythView.madeBySquares = true
        }
    }

    @IBAction func originChanged(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            snapshot = self.pythView.snapshotView(afterScreenUpdates: false)
            snapshot?.alpha = 0.8
            self.pythView.addSubview(snapshot!)
        case .changed:
            let translation = sender.translation(in: pythView)
            if translation == CGPoint.zero { break }
            snapshot?.center.x += translation.x
            snapshot?.center.y += translation.y
            sender.setTranslation(CGPoint.zero, in: pythView)
        case .ended:
            pythView.origin.x += snapshot!.frame.origin.x
            pythView.origin.y += snapshot!.frame.origin.y
            snapshot!.removeFromSuperview()
            snapshot = nil
        default:
            break
        }
    }

    @IBAction func startLineChanged(_ sender: UIPinchGestureRecognizer) {
        switch sender.state {
        case .began:
            snapshot = self.pythView.snapshotView(afterScreenUpdates: false)
            snapshot?.alpha = 0.8
            self.pythView.addSubview(snapshot!)
        case .changed:
            if sender.scale == Constants.scaleZero {
                break
            }
            let touchLocation = sender.location(in: self.pythView)
            snapshot!.frame.size.height *= sender.scale
            snapshot!.frame.size.width *= sender.scale
            snapshot!.frame.origin.x = snapshot!.frame.origin.x * sender.scale + (1 - sender.scale) * touchLocation.x
            snapshot!.frame.origin.y = snapshot!.frame.origin.y * sender.scale + (1 - sender.scale) * touchLocation.y
            sender.scale = Constants.scaleDefault
        case .ended:
            let changedScale = snapshot!.frame.height / self.pythView!.frame.height
            pythView!.origin.x = pythView!.origin.x * changedScale + snapshot!.frame.origin.x
            pythView!.origin.y = pythView!.origin.y * changedScale + snapshot!.frame.origin.y
            snapshot!.removeFromSuperview()
            snapshot = nil
            // old code
            pythView.startLength *= changedScale
            pythView.endLength *= changedScale
            pythView.lengthChangeColor *= changedScale
        default:
            break
        }
    }

    @IBAction func angleChanged(_ sender: UISlider) {
        pythView.addedAngle = CGFloat(sender.value)
        angle.text = pythView.addedAngle.formatted(format: Constants.angleTextFormat)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        let originX = view.bounds.midX
        let originY = pythView.bounds.midY
        pythView.origin = CGPoint(x: originX, y: originY)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
