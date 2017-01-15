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

class PythViewController: UIViewController {
    @IBOutlet weak var pythView: PythTreeView!
    @IBOutlet weak var angle: UILabel!
    @IBAction func changeTreeType(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 1:
            pythView.madeBySquares = false
        default:
            pythView.madeBySquares = true
        }
    }

    @IBAction func startLineChanged(_ sender: UIPinchGestureRecognizer) {
        switch sender.state {
        case .changed:
            pythView.startLength *= sender.scale
            pythView.endLength *= sender.scale
            pythView.lengthChangeColor *= sender.scale
            sender.scale = 1.0
        default:
            break
        }
    }

    @IBAction func angleChanged(_ sender: UISlider) {
        pythView.addedAngle = CGFloat(sender.value)
        angle.text = pythView.addedAngle.formatted(format: ".3")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
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
