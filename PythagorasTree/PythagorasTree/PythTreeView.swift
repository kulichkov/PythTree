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
}

@IBDesignable
class PythTreeView: UIView {

    var madeBySquares = true
    var lineWidth: CGFloat = 1.0
    var startLength: CGFloat = 40.0
    var lengthChangeColor: CGFloat = 5.0
    var endLength: CGFloat = 1.0
    var addedAngle: CGFloat = 0.0
    var leafColor = UIColor.black
    var branchColor = UIColor.black

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

    private func drawSquareTree(origin: CGPoint, length: CGFloat, angle: CGFloat) {
        if length < endLength { return }
        let color = (length < lengthChangeColor) ? leafColor : branchColor
        drawSquare(origin: origin, length: length, angle: angle, color: color)
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
        drawSquareTree(origin: firstPoint, length: firstLength, angle: firstRotationAngle)
        drawSquareTree(origin: secondPoint, length: secondLength, angle: secondRotationAngle)
    }

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let angle: CGFloat = 0.0
        let point = CGPoint(x: self.frame.midX - startLength/2, y: self.frame.midY + startLength/2)
        drawSquareTree(origin: point, length: startLength, angle: angle)
    }
}
