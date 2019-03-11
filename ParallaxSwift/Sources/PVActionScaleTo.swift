//
//  PVActionScaleTo.swift
//  ParallaxSwift
//
//  Created by Tom Nguyen on 4/19/16.
//  Copyright © 2016 Tom Nguyen. All rights reserved.
//

import Foundation
import UIKit

public class PVActionScaleTo : PVActionScaleBy {
    override func setupInputs() {
        _start = startValue
        _delta = endValue - startValue
    }
}
