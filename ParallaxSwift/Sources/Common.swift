//
//  Common.swift
//  ParallaxSwift
//
//  Created by Tom Nguyen on 1/22/16.
//  Copyright © 2016 Tom Nguyen. All rights reserved.
//

import Foundation
import UIKit


public func pvp(x: CGFloat, y: CGFloat)-> CGPoint {
    return CGPoint(x: x, y: y)
}

public func pvs(w: CGFloat, h: CGFloat) -> CGSize {
    return CGSize(width: w, height: h)
}

public func pvClamp<T : Comparable>(value: T, minValue : T, maxValue: T)->T {
    return min(max(value, minValue), maxValue)
}


public extension CGFloat {
    var radianValue : CGFloat {
        return self * CGFloat(M_PI / 180.0)
    }
    var degreeValue : CGFloat {
        return self * CGFloat(180.0 / M_PI)
    }
}


//operators
//CGPoint
public func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return pvp(lhs.x + rhs.x, y: lhs.y + rhs.y)
}

public func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return pvp(lhs.x - rhs.x, y: lhs.y - rhs.y)
}

public func * (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return pvp(lhs.x * rhs.x, y: lhs.y * rhs.y)
}

public func / (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return pvp(lhs.x / rhs.x, y: lhs.y / rhs.y)
}

public func += ( lhs: inout CGPoint, rhs: CGPoint) {
    lhs = lhs + rhs
}

public func -= ( lhs: inout CGPoint, rhs: CGPoint) {
    lhs = lhs - rhs
}

public func *= ( lhs: inout CGPoint, rhs: CGPoint) {
    lhs = lhs * rhs
}

public func /= ( lhs: inout CGPoint, rhs: CGPoint) {
    lhs = lhs / rhs
}

public func - (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
    return pvp(x: lhs.x - rhs, y: lhs.y - rhs)
}

public func + (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
    return pvp(x: lhs.x + rhs, y: lhs.y + rhs)
}

public func * (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
    return pvp(x: lhs.x * rhs, y: lhs.y * rhs)
}

public func / (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
    return pvp(x: lhs.x / rhs, y: lhs.y / rhs)
}


public func += ( lhs: inout CGPoint, rhs: CGFloat) {
    lhs = lhs + rhs
}

public func -= ( lhs: inout CGPoint, rhs: CGFloat) {
    lhs = lhs - rhs
}

public func /= ( lhs: inout CGPoint, rhs: CGFloat) {
    lhs = lhs / rhs
}

public func *= ( lhs: inout CGPoint, rhs: CGFloat) {
    lhs = lhs * rhs
}

//CGSize
public func + (lhs: CGSize, rhs: CGSize) -> CGSize {
    return pvs(w: lhs.width + rhs.width, h: lhs.height + rhs.height)
}

public func - (lhs: CGSize, rhs: CGSize) -> CGSize {
    return pvs(w: lhs.width - rhs.width, h: lhs.height - rhs.height)
}

public func * (lhs: CGSize, rhs: CGSize) -> CGSize {
    return pvs(w: lhs.width * rhs.width, h: lhs.height * rhs.height)
}

public func / (lhs: CGSize, rhs: CGSize) -> CGSize {
    return pvs(w: lhs.width / rhs.width, h: lhs.height / rhs.height)
}

public func += ( lhs: inout CGSize, rhs: CGSize) {
    lhs = lhs + rhs
}

public func -= ( lhs: inout CGSize, rhs: CGSize) {
    lhs = lhs - rhs
}

public func *= ( lhs: inout CGSize, rhs: CGSize) {
    lhs = lhs * rhs
}

public func /= ( lhs: inout CGSize, rhs: CGSize) {
    lhs = lhs / rhs
}

public func + (lhs: CGSize, rhs: CGFloat) -> CGSize {
    return pvs(w: lhs.width + rhs, h: lhs.height + rhs)
}

public func - (lhs: CGSize, rhs: CGFloat) -> CGSize {
    return pvs(w: lhs.width - rhs, h: lhs.height - rhs)
}

public func * (lhs: CGSize, rhs: CGFloat) -> CGSize {
    return pvs(w: lhs.width * rhs, h: lhs.height * rhs)
}

public func / (lhs: CGSize, rhs: CGFloat) -> CGSize {
    return pvs(w: lhs.width / rhs, h: lhs.height / rhs)
}

public func += ( lhs: inout CGSize, rhs: CGFloat) {
    lhs = lhs + rhs
}

public func -= ( lhs: inout CGSize, rhs: CGFloat) {
    lhs = lhs - rhs
}

public func /= ( lhs: inout CGSize, rhs: CGFloat) {
    lhs = lhs / rhs
}

public func *= ( lhs: inout CGSize, rhs: CGFloat) {
    lhs = lhs * rhs
}

//String
extension String {
    public func cgFloatComponentsSeparatedByString(separator : String) -> [CGFloat] {
        return self.components(separatedBy: separator).map({CGFloat(($0 as NSString).floatValue)})
    }
    public func integerComponentsSeparatedByString(separator : String) -> [Int] {
        return self.components(separatedBy: separator).map({($0 as NSString).integerValue})
    }
}

//Transform
public func rotateTransformWithX(x: CGFloat, y: CGFloat, z: CGFloat, m34 _m34: CGFloat) -> CATransform3D{
    var identityTransform = CATransform3DIdentity
    identityTransform.m34 = _m34
    let rotateX = CATransform3DRotate(identityTransform, x, 1, 0, 0)
    let rotateY = CATransform3DRotate(identityTransform, y, 0, 1, 0)
    let rotateZ = CATransform3DRotate(identityTransform, z, 0, 0, 1)
    return CATransform3DConcat(CATransform3DConcat(rotateX, rotateY), rotateZ)
}

typealias PVRotation = (x : CGFloat, y : CGFloat, z : CGFloat)



