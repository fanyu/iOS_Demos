//
//  ReplicatorView.swift
//  CAReplicatorLayer
//
//  Created by FanYu on 26/2/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//
import UIKit

protocol ActivityIndicatorViewProtocol {
    func setupAnimationInLayer(layer: CALayer, size: CGFloat, tintColor: UIColor)
}


enum ActivityIndicatorType {
    case Pulse
    case ThreeDotsScale
    case DotTriangle
    case GridDots
    
    func animation() -> ActivityIndicatorViewProtocol {
        switch self {
        case .Pulse:
            return PulseAnimation()
        case .ThreeDotsScale:
            return ThreeDotsScaleAnimation()
        case .DotTriangle:
            return DotTriangleAnimation()
        case .GridDots:
            return GridDotsAnimation()
        }
    }
}


class ActivityIndicatorView: UIView {

    private var indicatorType: ActivityIndicatorType
    private var indicatorSize: CGFloat = 40.0
    private var _tintColor = UIColor.whiteColor()
    private var isAnimating = false
    
    init(frame: CGRect, indicatorType: ActivityIndicatorType, tintColor: UIColor, indicatorSize: CGFloat) {
        
        self.indicatorSize = indicatorSize
        self.indicatorType = indicatorType
        _tintColor = tintColor
        
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAnimation() {
        layer.sublayers = nil
        
        let animation: ActivityIndicatorViewProtocol = indicatorType.animation()
        animation.setupAnimationInLayer(layer, size: indicatorSize, tintColor: _tintColor)
        
        layer.speed = 0.0
    }
    
    func startAnimating() {
        if layer.sublayers == nil {
            setupAnimation()
        }
        layer.speed = 1.0
        isAnimating = true
    }
    
    func stopAnimation() {
        layer.speed = 0.0
        isAnimating = false
    }
}
