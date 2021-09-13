//
//  CustomProgressView.swift
//  swifty-companion
//
//  Created by Anastasia on 16.08.2021.
//

import UIKit

final class CustomProgressView: UIProgressView {

    override func layoutSubviews() {
        super.layoutSubviews()
        let maskLayerPath = UIBezierPath(roundedRect: bounds,
                                         cornerRadius: self.frame.height / 2)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskLayerPath.cgPath
        layer.mask = maskLayer
    }

}
