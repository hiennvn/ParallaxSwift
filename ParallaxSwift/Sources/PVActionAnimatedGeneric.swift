//
//  PVActionAnimatedGeneric.swift
//  ParallaxSwift
//
//  Created by Tom Nguyen on 4/19/16.
//  Copyright © 2016 Tom Nguyen. All rights reserved.
//

import Foundation
import UIKit
public class PVActionAnimatedGeneric : PVActionAnimated {
    @IBInspectable public var relativePosition : Bool = true
    //Beginning
    @IBInspectable public var startPosition : CGPoint = pvp(x: 0, y: 0)
    @IBInspectable public var startOpacity : Float = 1.0
    @IBInspectable public var startScale : CGPoint = pvp(x: 1, y: 1)
    @IBInspectable public var startM34 : CGFloat = 0
    @IBInspectable public var startRotation : String = "0,0,0"
    
    //Appearing
    @IBInspectable public var appearSpringDamping : CGFloat = 0.75
    @IBInspectable public var appearSpringVelocity : CGFloat = 1.0
    @IBInspectable public var appearPosition : CGPoint?
    @IBInspectable public var appearOpacity : Float?
    @IBInspectable public var appearScale : CGPoint?
    @IBInspectable public var appearM34 : CGFloat?
    @IBInspectable public var appearRotation : String?
    
    //Disappearing
    @IBInspectable public var disappearSpringDamping : CGFloat?
    @IBInspectable public var disappearSpringVelocity : CGFloat?
    @IBInspectable public var disappearPosition : CGPoint?
    @IBInspectable public var disappearOpacity : Float?
    @IBInspectable public var disappearScale : CGPoint?
    @IBInspectable public var disappearM34 : CGFloat?
    @IBInspectable public var disappearRotation : String?
    
    private lazy var _startPosition : CGPoint = {[unowned self] in
        if let size = self.target?.superview?.bounds.size, self.relativePosition{
            return pvp(self.startPosition.x * size.width, y: self.startPosition.y * size.height)
        } else {
            return self.startPosition
        }
    }()
    
    
    
    private lazy var _startRotation : PVRotation = {[unowned self] in
        let components = self.startRotation.cgFloatComponentsSeparatedByString(",")
        return (components[0].radianValue,components[1].radianValue,components[2].radianValue)
    }()
    
    private lazy var _appearPosition : CGPoint = {[unowned self] in
        guard let position = self.appearPosition else {
            return self._startPosition
        }
        
        if let size = self.target?.superview?.bounds.size where self.relativePosition {
            return pvp(position.x * size.width, y: position.y * size.height)
        } else {
            return position
        }
    }()
    
    private lazy var _appearRotation : PVRotation = {[unowned self] in
        guard let rotation = self.appearRotation else {
            return self._startRotation
        }
        let components = rotation.cgFloatComponentsSeparatedByString(",")
        return (components[0].radianValue,components[1].radianValue,components[2].radianValue)
    }()
    
    private lazy var _disappearPosition : CGPoint = {[unowned self] in
        guard let position = self.disappearPosition else {
            return self._startPosition
        }
        if let size = self.target?.superview?.bounds.size where self.relativePosition {
            return pvp(position.x * size.width, y: position.y * size.height)
        } else {
            return position
        }
    }()
    
    private lazy var _disappearRotation : PVRotation = {[unowned self] in
        guard let rotation = self.disappearRotation else {
            return self._startRotation
        }
        let components = rotation.cgFloatComponentsSeparatedByString(",")
        return (components[0].radianValue,components[1].radianValue,components[2].radianValue)
    }()
    
    private var firstTime = true
    
    public override func setups() {
        super.setups()
        self.target?.layer.actions = [
            "position": NSNull(),
            "transform": NSNull(),
            "opacity": NSNull()
        ]
    }
    
    public override func appearAnimate() {
        if firstTime {
            firstTime = false
            self.applyAnimationToPosition(self._appearPosition, fromPos: _startPosition, toOpacity: self.appearOpacity ?? self.startOpacity, fromOpacity: startOpacity, toRotation: self._appearRotation, fromRotation: _startRotation, toM34: self.appearM34 ?? self.startM34, fromM34: startM34, toScale: self.appearScale ?? self.startScale, fromScale: startScale)
        } else {
            self.applyAnimationToPosition(self._appearPosition, fromPos: nil, toOpacity: self.appearOpacity ?? self.startOpacity, fromOpacity: nil, toRotation: self._appearRotation, fromRotation: nil, toM34: self.appearM34 ?? self.startM34, fromM34: nil, toScale: self.appearScale ?? self.startScale, fromScale: nil)
        }
    }
    
    public override func disappearAnimate() {
        self.applyAnimationToPosition(_disappearPosition, fromPos: nil, toOpacity: disappearOpacity ?? startOpacity, fromOpacity: nil, toRotation: _disappearRotation, fromRotation: nil, toM34: disappearM34 ?? startM34, fromM34: nil, toScale: disappearScale ?? startScale, fromScale: nil)
    }
    
    public override func restartAnimate() {
        self.applyAnimationToPosition(_startPosition, fromPos: nil, toOpacity: startOpacity, fromOpacity: nil, toRotation: _startRotation, fromRotation: nil, toM34: startM34, fromM34: nil, toScale: startScale, fromScale: nil)
    }

    private func setTargetPosition(pos : CGPoint, opacity: Float, rotation: PVRotation, m34: CGFloat, scale: CGPoint) {
        self.target?.layer.position = pos
        self.target?.layer.opacity = opacity
        self.target?.layer.transform = transformWithRotation(rotation, scale: scale, m34: m34)
    }

    private func transformWithRotation(rotation: PVRotation, scale: CGPoint, m34: CGFloat) -> CATransform3D{
        let rotateTransform = rotateTransformWithX(rotation.x, y: rotation.y, z: rotation.z, m34: m34)
        let scaleTransform = CATransform3DMakeScale(scale.x, scale.y, 1)
        return CATransform3DConcat(scaleTransform, rotateTransform)
    }
    
    private func positionAnimationFrom(from: CGPoint, to: CGPoint) -> CABasicAnimation {
        let posAnim = CABasicAnimation(keyPath: "position")
        posAnim.fromValue = NSValue(CGPoint: from)
        posAnim.toValue = NSValue(CGPoint: to)
        return posAnim
    }
    
    private func opacityAnimationFrom(from: Float, to: Float) -> CABasicAnimation {
        let opacityAnim = CABasicAnimation(keyPath: "opacity")
        opacityAnim.fromValue = from
        opacityAnim.toValue = to
        return opacityAnim
    }
    
    private func applyAnimationToPosition(toPos: CGPoint, fromPos: CGPoint?,  toOpacity: Float, fromOpacity: Float?, toRotation: PVRotation, fromRotation: PVRotation?, toM34: CGFloat, fromM34: CGFloat?, toScale: CGPoint, fromScale: CGPoint?) {
        let posAnim = CABasicAnimation(keyPath: "position")
        if let pos = fromPos {
            posAnim.fromValue = NSValue(CGPoint: pos)
        }
        posAnim.toValue = NSValue(CGPoint: toPos)
        
        let opacityAnim = CABasicAnimation(keyPath: "opacity")
        if let opacity = fromOpacity {
            opacityAnim.fromValue = opacity
        }
        opacityAnim.toValue = toOpacity
        
        let transformAnim = CABasicAnimation(keyPath: "transform")
        if let rotation = fromRotation, scale = fromScale, m34 = fromM34 {
            transformAnim.fromValue = NSValue(CATransform3D: transformWithRotation(rotation, scale: scale, m34: m34))
        }
        transformAnim.toValue = NSValue(CATransform3D: transformWithRotation(toRotation, scale: toScale, m34: toM34))
        
        [posAnim, opacityAnim, transformAnim].forEach { (anAnim) in
            anAnim.duration = duration
            anAnim.fillMode = kCAFillModeBackwards
            anAnim.beginTime = CACurrentMediaTime() + Double(delay)
            anAnim.removedOnCompletion = true
            anAnim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            self.target?.layer.applyAnimation(anAnim)
        }
    }
}

extension PVActionAnimatedGeneric {
    public override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        switch key {
        case "appearPosition":
            appearPosition = value?.CGPointValue()
        case "appearOpacity" :
            appearOpacity = value?.floatValue
        case "appearScale" :
            appearScale = value?.CGPointValue()
        case "appearM34" :
            if let m34 = value?.floatValue {
                appearM34 = CGFloat(m34)
            } else{
                appearM34 = nil
            }
        case "disappearSpringDamping" :
            if let damping = value?.floatValue {
                disappearSpringDamping = CGFloat(damping)
            } else {
                disappearSpringDamping = nil
            }
        case "disappearSpringVelocity" :
            if let velocity = value?.floatValue {
                disappearSpringVelocity = CGFloat(velocity)
            } else {
                disappearSpringVelocity = nil
            }
        case "disappearPosition":
            disappearPosition = value?.CGPointValue()
        case "disappearOpacity":
            disappearOpacity = value?.floatValue
        case "disappearScale":
            disappearScale = value?.CGPointValue()
        case "disappearM34":
            if let m34 = value?.floatValue {
                disappearM34 = CGFloat(m34)
            } else{
                disappearM34 = nil
            }
        default:
            super.setValue(value, forUndefinedKey: key)
        }
    }
}
