//
//  PythTreeView.swift
//  PythagorasTree
//
//  Created by Mikhail Kulichkov on 01/12/16.
//  Copyright © 2016 Mikhail Kulichkov. All rights reserved.
//

import UIKit

enum Constants {
    static let angle = M_PI_2
    static let endLength = 0.7
}

@IBDesignable
class PythTreeView: UIView {

    var madeBySquares = true
    var lineWidth: CGFloat = 1.0
    var startLength: CGFloat = 40.0
    var changeLength: CGFloat = 10.0
    var endLength: CGFloat = 0.7
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


    private func drawSquare(point: CGPoint, length: CGFloat, angle: CGFloat, color: UIColor) {
        color.set()
        let rect = CGRect(x: point.x, y: point.y, width: length, height: length)
        let path = UIBezierPath(rect: rect)
        path.stroke()
    }

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }

}
