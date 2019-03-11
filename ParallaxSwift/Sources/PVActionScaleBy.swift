//
//  PVActionScaleBy.swift
//  ParallaxSwift
//
//  Created by Tom Nguyen on 4/19/16.
//  Copyright © 2016 Tom Nguyen. All rights reserved.
//

import Foundation
import UIKit

public class PVActionScaleBy : PVActionInteractive {
    var _start : CGPoint!
    var _delta: CGPoint!
    @IBInspectable public var startValue : CGPoint = pvp(0, y: 0)
    @IBInspectable public var endValue: CGPoint = pvp(0, y: 0)
    
    public override func setups() {
        super.setups()
        setupInputs()
        target.layer.scaleTransfrom = CATransform3DMakeScale(_start.x, _start.y, 1.0)
    }
    
    func setupInputs(){
        _start = startValue
        _delta = endValue
    }
    
    public override func step(fraction: CGFloat) {
        let newScale = _start + (_delta * fraction)
        let scaleTransform = CATransform3DMakeScale(newScale.x, newScale.y, 1.0)
        let rotateTransform = target.layer.rotateTransfrom
        target.layer.scaleTransfrom = scaleTransform
        target.layer.transform = CATransform3DConcat(scaleTransform, rotateTransform)
    }
}
