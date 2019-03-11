//
//  PVActionMoveAlongCircleTo.swift
//  ParallaxSwift
//
//  Created by Tom Nguyen on 4/19/16.
//  Copyright © 2016 Tom Nguyen. All rights reserved.
//

import Foundation
import UIKit

public class PVActionMoveAlongCircleTo : PVActionMoveAlongCircleBy {
    override func setupInputs() {
        _start = startAngle.radianValue
        _delta = (endAngle - startAngle).radianValue
    }
}
