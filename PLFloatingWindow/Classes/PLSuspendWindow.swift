//
//  PLSuspendWindow.swift
//  PLFloatingWindow
//
//  Created by 彭磊 on 2020/7/21.
//

import UIKit

protocol PLSuspendWindowDelegate: class {
    func suspendWindowDidTap(_ suspendWindwo: PLSuspendWindow)
}

class PLSuspendWindow: UIWindow {

    weak var delegate: PLSuspendWindowDelegate?
       
        private lazy var iconView: PLSuspendView = {
            let v = PLSuspendView()
            v.backgroundColor = UIColor.white
            return v
        }()
        
        private var panStartPoint: CGPoint = .zero
        private var panStartCenter: CGPoint = .zero
        
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.backgroundColor = UIColor.init(white: 1, alpha: 0)
            setupUI()
        }
        
    @available(iOS 13.0, *)
    public override init(windowScene: UIWindowScene) {
            if #available(iOS 13.0, *) {
                super.init(windowScene: windowScene)
                setupUI()
            } else {
                fatalError("")
            }
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }

extension PLSuspendWindow {
    private func setupUI() {
        alpha = 0
        clipsToBounds = true
        isUserInteractionEnabled = true
        windowLevel = UIWindow.Level(1000)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap(gesture:))))
        addSubview(iconView)
        iconView.snp.makeConstraints { (make) in
            make.size.equalTo(PLSuspendViewConfig.suspendViewSize)
//            make.centerX.equalToSuperview()
            make.left.equalTo(10)
            make.top.equalTo(20)
        }
        
        iconView.show()
    }
    
    @objc private func didTap(gesture: UITapGestureRecognizer) {
        delegate?.suspendWindowDidTap(self)
    }

    // 赋值
    public func fillModel(model: PLGuideModel) {
        
    }

}
