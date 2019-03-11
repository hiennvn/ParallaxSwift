//
//  PVActionRotateTo.swift
//  ParallaxSwift
//
//  Created by Tom Nguyen on 4/19/16.
//  Copyright © 2016 Tom Nguyen. All rights reserved.
//

import Foundation
import UIKit

public class PVActionRotateTo : PVActionRotateBy {
    override func setupInputs() {
        _start = (startX.radianValue, startY.radianValue, startZ.radianValue)
        _delta = ((endX - startX).radianValue, (endY - startY).radianValue, (endZ - startZ).radianValue)
    }
}
