//
//  PythTreeView.swift
//  PythagorasTree
//
//  Created by Mikhail Kulichkov on 01/12/16.
//  Copyright © 2016 Mikhail Kulichkov. All rights reserved.
//

import UIKit

fileprivate enum Constants {
    static let piDivByFour = CGFloat(M_PI_4)
    static let piDivByTwo = CGFloat(M_PI_2)
    static let zero: CGFloat = 0.0
    static let scaleDefault: CGFloat = 1.0
}

//@IBDesignable
class PythTreeView: UIView {
    fileprivate var snapshot: UIView?
    var origin = CGPoint(x: 0.0, y: 0.0) {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable
    var madeBySquares: Bool = true {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable
    var lineWidth: CGFloat = 1.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable
    var startLength: CGFloat = 40.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable
    var lengthChangeColor: CGFloat = 15.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable
    var endLength: CGFloat = 5.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable
    var addedAngle: CGFloat = 0.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable
    var leafColor: UIColor = UIColor(red: 64/255, green: 175/255, blue: 40/55, alpha: 1.0) {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable
    var branchColor: UIColor = UIColor(red: 110/255, green: 50/255, blue: 40/55, alpha: 1.0) {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable
    var fillSquare: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }

    private func drawLine(origin: CGPoint, length: CGFloat, angle: CGFloat, color: UIColor) {
        color.set()
        var point = origin
        let path = UIBezierPath()
        path.lineWidth = lineWidth
        path.move(to: point)
        point.x += length * cos(angle);
        point.y -= length * sin(angle);
        path.addLine(to: point)
        path.stroke()
    }

    private func drawSquare(origin: CGPoint, length: CGFloat, angle: CGFloat, color: UIColor) {
        color.set()
        var point = origin
        let path = UIBezierPath()
        path.lineWidth = lineWidth
        path.move(to: point)
        point.x += length * cos(angle);
        point.y -= length * sin(angle);
        path.addLine(to: point)
        point.x += length * cos(Constants.piDivByTwo + angle);
        point.y -= length * sin(Constants.piDivByTwo + angle);
        path.addLine(to: point)
        point.x -= length * cos(angle);
        point.y += length * sin(angle);
        path.addLine(to: point)
        point.x += length * cos(Constants.piDivByTwo - angle);
        point.y += length * sin(Constants.piDivByTwo - angle);
        path.addLine(to: point)
        path.stroke()
        if fillSquare { path.fill() }
    }

    private func drawLineTree(origin: CGPoint, length: CGFloat, angle: CGFloat) {
        if length < endLength { return }
        let color = (length < lengthChangeColor) ? leafColor : branchColor
        let newAngle = Constants.piDivByFour + addedAngle
        let firstX = origin.x + length * cos(angle)
        let firstY = origin.y - length * sin(angle)
        let firstPoint = CGPoint(x: firstX, y: firstY)
        let firstAngle = angle + Constants.piDivByFour + addedAngle
        let firstLength = length * cos(newAngle)
        let secondX = origin.x + length * cos(angle)
        let secondY = origin.y - length * sin(angle)
        let secondPoint = CGPoint(x: secondX, y: secondY)
        let secondLength = length * sin(newAngle)
        let secondAngle = angle - Constants.piDivByFour + addedAngle
        drawLine(origin: origin, length: length, angle: angle, color: color)
        drawLineTree(origin: firstPoint, length: firstLength, angle: firstAngle)
        drawLineTree(origin: secondPoint, length: secondLength, angle: secondAngle)
    }

    private func drawSquareTree(origin: CGPoint, length: CGFloat, angle: CGFloat) {
        if length < endLength { return }
        let color = (length < lengthChangeColor) ? leafColor : branchColor
        let newAngle = Constants.piDivByFour + addedAngle
        let firstX = origin.x - length * sin(angle)
        let firstY = origin.y - length * cos(angle)
        let firstPoint = CGPoint(x: firstX, y: firstY)
        let firstLength = length * cos(newAngle)
        let firstRotationAngle = angle + newAngle
        let secondX = origin.x - length * (sin(angle) - cos(newAngle) * cos(newAngle + angle))
        let secondY = origin.y - length * (cos(angle) + cos(newAngle) * sin(newAngle + angle))
        let secondPoint = CGPoint(x: secondX, y: secondY)
        let secondLength = length * sin(newAngle)
        let secondRotationAngle = addedAngle + angle - Constants.piDivByFour
        drawSquare(origin: origin, length: length, angle: angle, color: color)
        drawSquareTree(origin: firstPoint, length: firstLength, angle: firstRotationAngle)
        drawSquareTree(origin: secondPoint, length: secondLength, angle: secondRotationAngle)
    }

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        if madeBySquares {
            var originOfSquare = origin
            originOfSquare.x -= startLength/2
            drawSquareTree(origin: originOfSquare,
                           length: startLength,
                           angle: Constants.zero)
        } else {
            drawLineTree(origin: origin,
                         length: startLength,
                         angle: Constants.piDivByTwo)
        }
    }

    func originReset(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended { origin = sender.location(in: self) }
    }

    func angleChanged(_ sender: UIRotationGestureRecognizer) {
        if sender.state == .changed {
            let newAddedAngle = addedAngle + sender.rotation
            if newAddedAngle > -0.5 && newAddedAngle < 0.5 {
                addedAngle = newAddedAngle
            }
            sender.rotation = Constants.zero
        }
    }

    func scaleChanged(_ sender: UIPinchGestureRecognizer) {
        switch sender.state {
        case .began:
            snapshot = self.snapshotView(afterScreenUpdates: false)
            snapshot?.alpha = 0.8
            self.addSubview(snapshot!)
        case .changed:
            if sender.scale == Constants.zero {
                break
            }
            let touchLocation = sender.location(in: self)
            snapshot!.frame.size.height *= sender.scale
            snapshot!.frame.size.width *= sender.scale
            snapshot!.frame.origin.x = snapshot!.frame.origin.x * sender.scale + (1 - sender.scale) * touchLocation.x
            snapshot!.frame.origin.y = snapshot!.frame.origin.y * sender.scale + (1 - sender.scale) * touchLocation.y
            sender.scale = Constants.scaleDefault
        case .ended:
            let changedScale = snapshot!.frame.height / self.frame.height
            origin.x = origin.x * changedScale + snapshot!.frame.origin.x
            origin.y = origin.y * changedScale + snapshot!.frame.origin.y
            snapshot!.removeFromSuperview()
            snapshot = nil
            // old code
            startLength *= changedScale
            endLength *= changedScale
            lengthChangeColor *= changedScale
        default:
            break
        }
    }

    func originMove(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            snapshot = self.snapshotView(afterScreenUpdates: false)
            snapshot?.alpha = 0.8
            self.addSubview(snapshot!)
        case .changed:
            let translation = sender.translation(in: self)
            if translation == CGPoint.zero { break }
            snapshot?.center.x += translation.x
            snapshot?.center.y += translation.y
            sender.setTranslation(CGPoint.zero, in: self)
        case .ended:
            origin.x += snapshot!.frame.origin.x
            origin.y += snapshot!.frame.origin.y
            snapshot!.removeFromSuperview()
            snapshot = nil
        default:
            break
        }
    }
}
