//
//  TreeViewController.swift
//  PythagorasTree
//
//  Created by Mikhail Kulichkov on 24/01/17.
//  Copyright © 2017 Mikhail Kulichkov. All rights reserved.
//

import UIKit

class TreeViewController: UIViewController {

    @IBOutlet weak var treeView: PythTreeView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        treeView.addGestureRecognizer(UIPinchGestureRecognizer(target: treeView, action: #selector(PythTreeView.scaleChanged)))
        treeView.addGestureRecognizer(UIPanGestureRecognizer(target: treeView, action: #selector(PythTreeView.originMove)))
        let doubleTapGestureRecognizer = UITapGestureRecognizer(target: treeView, action: #selector(PythTreeView.originReset))
        doubleTapGestureRecognizer.numberOfTapsRequired = 2
        doubleTapGestureRecognizer.numberOfTouchesRequired = 1
        treeView.addGestureRecognizer(doubleTapGestureRecognizer)
    }

    override func viewDidAppear(_ animated: Bool) {
        //Move origin to center
        treeView.origin = CGPoint(x: treeView.bounds.midX, y: treeView.bounds.midY + treeView.bounds.midY/3)
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
