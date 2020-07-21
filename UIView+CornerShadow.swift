//
//  UIView+CornerShadow.swift
//  GMJKExtension
//
//  Created by 彭磊 on 2019/11/29.
//

import UIKit

extension UIView {
    /// 添加阴影
    public func jk_addShadow(color: UIColor, offset: CGSize, opacity: Float, shadowRadius: CGFloat = 0.5) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.shadowRadius = shadowRadius
    }
    /// 设置圆角
    public func jk_makeCorners(_ corner:UIRectCorner, cornerRadii:CGSize) {
        
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corner, cornerRadii: cornerRadii)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    /// 同时设置圆角和阴影
    /// - Parameters:
    ///   - corner: 圆角位置
    ///   - cornerRadii: 圆角大小
    ///   - shadowColor: 阴影颜色
    ///   - shadowOffset: 阴影偏移量
    ///   - shadowOpacity: 阴影不透明度
    ///   - shadowRadius: 阴影模糊半径
    public func jk_applyShadowCorner(corner:UIRectCorner, cornerRadii:CGSize, shadowColor: UIColor = .gray, shadowOffset: CGSize = .zero, shadowOpacity: Float = 0.5, shadowRadius: CGFloat = 0.5) {
        guard let _ = superview else {
            return
        }
        let shadow = UIView()
        shadow.translatesAutoresizingMaskIntoConstraints = false
        shadow.layer.shouldRasterize = true
        shadow.layer.rasterizationScale = UIScreen.main.scale
        shadow.clipsToBounds = false
        shadow.backgroundColor = .clear
        superview?.insertSubview(shadow, belowSubview: self)
        let constraints = [
            NSLayoutConstraint(item: shadow, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: shadow, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: shadow, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: shadow, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0),
        ]
        superview?.addConstraints(constraints)
        
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corner, cornerRadii: cornerRadii)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
        
        shadow.layer.shadowColor = shadowColor.cgColor
        shadow.layer.shadowOffset = shadowOffset
        shadow.layer.shadowOpacity = shadowOpacity
        shadow.layer.shadowRadius = shadowRadius
        shadow.layer.shadowPath = maskPath.cgPath
        
    }
    
    
}

