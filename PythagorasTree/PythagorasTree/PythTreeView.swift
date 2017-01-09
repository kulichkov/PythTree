//
//  PythTreeView.swift
//  PythagorasTree
//
//  Created by Mikhail Kulichkov on 01/12/16.
//  Copyright © 2016 Mikhail Kulichkov. All rights reserved.
//

import UIKit

enum Constants {
    static let piDivByFour = CGFloat(M_PI_4)
    static let piDivByTwo = CGFloat(M_PI_2)
    static let zero: CGFloat = 0.0
}

@IBDesignable
class PythTreeView: UIView {
    @IBInspectable
    var madeBySquares: Bool = false
    @IBInspectable
    var lineWidth: CGFloat = 1.0
    @IBInspectable
    var startLength: CGFloat = 40.0
    @IBInspectable
    var lengthChangeColor: CGFloat = 5.0
    @IBInspectable
    var endLength: CGFloat = 1.0
    @IBInspectable
    var addedAngle: CGFloat = 0.0
    @IBInspectable
    var leafColor: UIColor = UIColor.black
    @IBInspectable
    var branchColor: UIColor = UIColor.black

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
            drawSquareTree(origin: CGPoint(x: self.frame.midX - startLength/2, y: self.frame.midY + startLength/2),
                           length: startLength,
                           angle: Constants.zero)
        } else {
            drawLineTree(origin: CGPoint(x: self.frame.midX, y: self.frame.midY + startLength/2),
                         length: startLength,
                         angle: Constants.piDivByTwo)
        }
    }
}
