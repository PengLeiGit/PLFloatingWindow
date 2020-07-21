//
//  PLSuspendView.swift
//  PLFloatingWindow
//
//  Created by 彭磊 on 2020/7/21.
//

import UIKit
import SnapKit

class PLSuspendView: UIView {

    private let damping: CGFloat = 0.8
        public var hideDuration: TimeInterval = 0.5
        public var animationDuration: TimeInterval = 3

        lazy var bgView: UIView = {
            let v = UIView()
            v.backgroundColor = .white
            return v
        }()
        
        lazy var backIcon: UIImageView = {
            let view = UIImageView()
            view.backgroundColor = UIColor.yellow
            view.isUserInteractionEnabled = true
            return view
        }()
        
        lazy var nameLabel: UILabel = {
            let lbl = UILabel()
            lbl.text = "恭喜你！下单任务已完成"
            lbl.textColor = .white
            return lbl
        }()
        
        lazy var detailLabel: UILabel = {
            let view = UILabel()
            view.text = "已累计得到10元红包"
            view.textColor = UIColor.black
            return view
        }()
        
        
        override init(frame: CGRect) {
            super.init(frame: frame)
    //        self.backgroundColor = UIColor.init(white: 1, alpha: 1)
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapG))
            self.addGestureRecognizer(tap)
            addSwipeGestureRecognizer()
            initUI()
        }

            
        required public init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
            
        private func initUI() {
            addSubview(bgView)
            bgView.addSubview(backIcon)
            bgView.addSubview(nameLabel)
            bgView.addSubview(detailLabel)
            
            bgView.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
            
            backIcon.snp.makeConstraints { (make) in
                make.left.equalTo(20)
                make.centerY.equalToSuperview()
                make.width.height.equalTo(50)
            }
            nameLabel.snp.makeConstraints { (make) in
                make.left.equalTo(backIcon.snp.right).offset(10)
                make.top.equalTo(backIcon)
                make.height.equalTo(20)
            }
            detailLabel.snp.makeConstraints { (make) in
                make.left.equalTo(nameLabel)
                make.top.equalTo(nameLabel.snp.bottom).offset(5)
                make.height.equalTo(20)
            }
        }
            
        override func layoutSubviews() {
            super.layoutSubviews()
            bgView.jk_applyShadowCorner(corner: .allCorners, cornerRadii: CGSize.init(width: 4, height: 4), shadowColor: UIColor.black, shadowOffset: CGSize.init(width: 0, height: 0), shadowOpacity: 0.1, shadowRadius: 12)
        }
        
        @objc func tapG() {
            print("点击")
        }
        
        // 添加手势
        func addSwipeGestureRecognizer() {
            let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeUpSelector))
            swipeUp.direction = .up
            addGestureRecognizer(swipeUp)
        }
        
        
        @objc func swipeUpSelector(ges: UISwipeGestureRecognizer) {
            if ges.direction == .up {
                hide()
            }
        }
        
        func show() {
            UIView.animate(withDuration: hideDuration, delay: 0, options: .curveEaseIn, animations: {
                    self.transform = CGAffineTransform(translationX: 0, y: 20)
                }) { (finish) in
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                self.hide()
            }
            
        }
        
        @objc func hide() {
            UIView.animate(withDuration: hideDuration, delay: 0, options: .curveEaseIn, animations: {
                self.transform = CGAffineTransform(translationX: 0, y: -self.frame.size.height - 60)
            }) { (finish) in
                PLSuspendViewManager.shared.removeSuspendView()
            }
        }

}
