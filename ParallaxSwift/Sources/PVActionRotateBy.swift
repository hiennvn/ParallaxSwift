//
//  PVActionRotateBy.swift
//  ParallaxSwift
//
//  Created by Tom Nguyen on 4/19/16.
//  Copyright © 2016 Tom Nguyen. All rights reserved.
//

import Foundation
import UIKit
public class PVActionRotateBy : PVActionInteractive {
    var _start : (x : CGFloat, y: CGFloat, z: CGFloat)!
    var _delta : (x : CGFloat, y: CGFloat, z: CGFloat)!
    
    @IBInspectable public var startX : CGFloat = 0
    @IBInspectable public var startY : CGFloat = 0
    @IBInspectable public var startZ : CGFloat = 0
    @IBInspectable public var endX : CGFloat = 0
    @IBInspectable public var endY : CGFloat = 0
    @IBInspectable public var endZ : CGFloat = 0
    @IBInspectable public var m34 : CGFloat  = 0
    
    public override func setups() {
        super.setups()
        setupInputs()
        target.layer.allowsEdgeAntialiasing = true
        target.layer.rotateTransfrom = rotateTransformWithX(_start.x, y: _start.y, z: _start.z, m34: m34)
    }
    func setupInputs() {
        _start = (startX.radianValue, startY.radianValue, startZ.radianValue)
        _delta = (endX.radianValue, endY.radianValue, endZ.radianValue)
    }

    public override func step(fraction: CGFloat) {
        let rotateTransform = rotateTransformWithX(_start.x + _delta.x * fraction,
                                                        y: _start.y + _delta.y * fraction,
                                                        z: _start.z + _delta.z * fraction,
                                                        m34: m34)
        let scaleTranform = target.layer.scaleTransfrom
        target.layer.rotateTransfrom = rotateTransform
        target.layer.transform = CATransform3DConcat(scaleTranform, rotateTransform)
    }
}
