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
    static let endLength = 0.7
}

@IBDesignable
class PythTreeView: UIView {

    var madeBySquares = true
    var lineWidth: CGFloat = 1.0
    var startLength: CGFloat = 40.0
    var changeLength: CGFloat = 10.0
    var minLength: CGFloat = 0.7
    var angle: CGFloat = 0.0



//
//    if (length > MIN_L) {
//
//    if (length > 10) {
//    CGContextSetStrokeColorWithColor(ctx, [UIColor brownColor].CGColor);
//    }
//    else
//    {
//    CGContextSetStrokeColorWithColor(ctx, [UIColor greenColor].CGColor);
//    }
//
//    CGContextMoveToPoint(ctx, point.x, point.y);
//    point.x += length * cos(angle);
//    point.y -= length * sin(angle);
//    CGContextAddLineToPoint(ctx, point.x, point.y);
//
//    point.x += length * cos(M_PI/2 + angle);
//    point.y -= length * sin(M_PI/2 + angle);
//    CGContextAddLineToPoint(ctx, point.x, point.y);
//
//    point.x -= length * cos(angle);
//    point.y += length * sin(angle);
//    CGContextAddLineToPoint(ctx, point.x, point.y);
//
//    point.x += length * cos(M_PI/2 - angle);
//    point.y += length * sin(M_PI/2 - angle);
//    CGContextAddLineToPoint(ctx, point.x, point.y);
//    CGContextStrokePath(ctx);
//
//
//    [self drawSquareTreeWithContext:ctx
//    andPoint:CGPointMake(point.x - length*sin(angle),
//    point.y - length*cos(angle))
//    andLength:length * cos(M_PI/X_ANGLE)
//    andAngle:(angle + M_PI/X_ANGLE)];
//
//
//    [self drawSquareTreeWithContext:ctx
//    andPoint:CGPointMake(point.x - length*(sin(angle) - cos(M_PI/X_ANGLE)*cos(M_PI/X_ANGLE + angle)),
//    point.y - length*(cos(angle) + cos(M_PI/X_ANGLE)*sin(M_PI/X_ANGLE + angle)))
//    andLength:length * sin(M_PI/X_ANGLE)
//    andAngle:-(M_PI_2 - M_PI/X_ANGLE - angle)
//    ];
//    
//    }


    private func drawSquare(origin: CGPoint, length: CGFloat, angle: CGFloat, color: UIColor) {
        color.set()
        let rect = CGRect(x: origin.x, y: origin.y, width: length, height: length)
        let rotation = CGAffineTransform(rotationAngle: angle)
        let path = UIBezierPath(rect: rect)
        let toAnchorPoint = CGAffineTransform(translationX: -origin.x, y: -origin.y)
        let fromAnchorPoint = CGAffineTransform(translationX: origin.x, y: origin.y)
        path.apply(toAnchorPoint)
        path.apply(rotation)
        path.apply(fromAnchorPoint)
        path.stroke()
    }

    private func drawTree(origin: CGPoint, length: CGFloat, angle: CGFloat) {
        if length < minLength { return }
//        let newPoints = drawSquare(origin: origin, length: length, angle: angle, color: UIColor.blue)
//        let leftAngle = Angle(direction: .toLeft, degree: Constants.angle + self.angle)
//        let rightAngle = Angle(direction: .toRight, degree: Constants.angle - self.angle)
//        let leftLength = length * cos(leftAngle.degree)
//        let rightLength = length * sin(leftAngle.degree)
//        drawTree(origin: newPoints.leftPoint, length: leftLength, angle: leftAngle)
//        drawTree(origin: newPoints.rightPoint, length: rightLength, angle: rightAngle)
    }

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        var angle: CGFloat = 0.0
        let length: CGFloat = 70.0
        let point = CGPoint(x: self.frame.midX - length/2, y: self.frame.midY - length/2)
        drawSquare(origin: point, length: length, angle: angle, color: UIColor.blue)
        angle = Constants.piDivByFour
        let leftLength = cos(angle)*length
        let rightLength = sin(angle)*length
        let leftX = point.x - leftLength*sin(angle)
        let rightX = point.x + leftLength*cos(angle)
        let leftY = point.y - leftLength*cos(angle)
        let rightY = point.y - leftLength*sin(angle)
        drawSquare(origin: CGPoint(x: leftX, y: leftY), length: leftLength, angle: -angle, color: UIColor.black)
        drawSquare(origin: CGPoint(x: rightX, y: rightY), length: rightLength, angle: -angle, color: UIColor.black)
    }
}
