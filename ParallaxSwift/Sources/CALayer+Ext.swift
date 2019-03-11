//
//  CALayer+Ext.swift
//  ParallaxSwift
//
//  Created by Tom Nguyen on 2/2/16.
//  Copyright © 2016 Tom Nguyen. All rights reserved.
//

import Foundation
import UIKit

public extension CALayer {
    private struct AssociatedKeys {
        static var ScaleTransform = "pv_scale_transfrom"
        static var RotateTransfrom = "pv_rotate_transfrom"
    }
    
    public var scaleTransfrom : CATransform3D {
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.ScaleTransform) as? NSValue)?.caTransform3DValue ?? CATransform3DIdentity
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.ScaleTransform, NSValue(caTransform3D: newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public var rotateTransfrom : CATransform3D {
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.RotateTransfrom) as? NSValue)?.caTransform3DValue ?? CATransform3DIdentity
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.RotateTransfrom, NSValue(caTransform3D: newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

public extension CALayer {
    func applyAnimation(animation: CABasicAnimation) {
//        let copy = animation.copy() as! CABasicAnimation
        if animation.fromValue == nil {
            animation.fromValue = self.presentation()?.value(forKeyPath: animation.keyPath!)
        }
        self.add(animation, forKey: animation.keyPath)
        self.setValue(animation.toValue, forKeyPath:animation.keyPath!)
    }
}
