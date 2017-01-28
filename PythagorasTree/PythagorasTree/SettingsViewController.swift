//
//  SettingsViewController.swift
//  PythagorasTree
//
//  Created by Mikhail Kulichkov on 26/01/17.
//  Copyright © 2017 Mikhail Kulichkov. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var fillSquaresSwitch: UISwitch!
    @IBOutlet var sliderValueLabels: [UILabel]!
    @IBOutlet var sliders: [UISlider]!
    @IBOutlet var branchColorSliders: [UISlider]!
    @IBOutlet weak var branchColorSlidersValueLable: UILabel!
    @IBOutlet var leafColorSliders: [UISlider]!
    @IBOutlet weak var leafColorSlidersValueLable: UILabel!
    @IBOutlet var backgroundColorSliders: [UISlider]!
    @IBOutlet weak var backgroundColorSlidersValueLable: UILabel!
    enum Row: Int {
        case elementType, fillSquares, lineWidth, firstLineLength, lastLineLength, leafLength, angle, branchColor, leafColor, backgroundColor
    }
    enum Slider: Int {
        case lineWidth, firstLineLength, lastLineLength, leafLength, angle
    }
    enum ColorSlider: Int {
        case red, green, blue
    }
    var fillSquaresSwitchIsVisible = true {
        didSet {
            relayoutTableViewCells()
        }
    }

    weak var treeViewController: TreeViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSliderValueLabels()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func elementTypeSegmentedControlChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 1:
            fillSquaresSwitchIsVisible = false
        default:
            fillSquaresSwitchIsVisible = true
        }
    }

    // MARK: - Helpers
    func relayoutTableViewCells() {
        tableView.beginUpdates()
        tableView.endUpdates()
    }

    func updateSliderValueLabels() {
        for slider in Slider.lineWidth.rawValue...Slider.angle.rawValue {
            updateSliderValueLabel(Slider(rawValue: slider)!)
        }
    }

    func updateSliderValueLabel(_ sliderEnum: Slider) {
        let index = sliderEnum.rawValue
        let label = sliderValueLabels[index]
        let slider = sliders[index]
        switch sliderEnum {
        case .angle:
            label.text = String(format: "%.3f", slider.value)
        case .firstLineLength, .lastLineLength, .leafLength, .lineWidth:
            label.text = String(format: "%.1f", slider.value)
        }
    }

    func colorAndLabelForSliders(_ sliders: [UISlider]) -> (color: CGColor, label: String) {
        let red = CGFloat(sliders[0].value)
        let green = CGFloat(sliders[1].value)
        let blue = CGFloat(sliders[2].value)
        let color = UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0).cgColor
        let label = "RGB: \(Int(red)), \(Int(green)), \(Int(blue))"
        return (color: color, label: label)
    }

    // MARK: - UITableViewDelegate

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = Row(rawValue: indexPath.row)!

        if row == .fillSquares {
            return fillSquaresSwitchIsVisible ? 44.0 : 0.0
        } else {
            return 44.0
        }
    }
}
