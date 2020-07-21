//
//  PLSuspendViewManager.swift
//  PLFloatingWindow
//
//  Created by 彭磊 on 2020/7/21.
//

import UIKit

extension UIDevice {
    /// 屏幕的比例
    public static let scale: CGFloat               = UIScreen.main.scale
    /// UI尺寸针对width == 375，缩放
    public static let zoomUI: CGFloat              = UIScreen.main.bounds.size.width / 375
    ///屏幕宽
    public static let width: CGFloat               = UIScreen.main.bounds.size.width
    ///屏幕高
    public static let height: CGFloat              = UIScreen.main.bounds.size.height
    ///状态栏高度
    public static let statusBarHeight: CGFloat     = UIApplication.shared.statusBarFrame.height
    /// tabbar的高度
    public static let tabBarHeight: CGFloat        = 49 + bottomSafeAreaHeight
    ///导航栏高度
    public static let navigationBarHeight: CGFloat = 44 + statusBarHeight
    /// 顶部安全区域的高度 (20 or 44)
    public static let topSafeAreaHeight: CGFloat   = UIDevice.safeAreaInsets().top
    /// 底部安全区域 (0 or 34)
    public static let bottomSafeAreaHeight: CGFloat = UIDevice.safeAreaInsets().bottom
    
    
    private static func safeAreaInsets() -> (top: CGFloat, bottom: CGFloat) {
        if #available(iOS 11.0, *) {
            let inset = UIApplication.shared.delegate?.window??.safeAreaInsets
            let top = inset?.top ?? 0
            return (top == 0 ? 20 : top, inset?.bottom ?? 0)
        } else {
            return (20, 0)
        }
    }
}


// MARK: -  基本配置
public struct PLSuspendViewConfig {
    
    /// 悬浮窗大小
    static let suspendViewSize = CGSize(width: UIScreen.main.bounds.width - 20, height: 80)
    /// 悬浮窗默认位置
    static let suspendViewRect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: suspendViewSize.height + 60)
    /// 悬浮窗边框颜色
    static let suspendBorderColor = UIColor.cyan
    /// 动画时间
    static let animateDuration: TimeInterval = 0.3
    
}

public class PLSuspendViewManager: NSObject {
    // 悬浮窗
    var suspendWindow:PLSuspendWindow?
    
    // 用于动画的imageView
    var fakerImageView: UIImageView?
    
    // MARK: - 初始化单例
    static let shared = PLSuspendViewManager()
    private override init() {
        super.init()
    }
}

// MARK: -  Public Methods
extension PLSuspendViewManager {
    // 添加悬浮窗
    func addSuspendView(model: PLGuideModel) {
        if suspendWindow == nil {
            if #available(iOS 13.0, *) {
                let windowScene = UIApplication.shared
                .connectedScenes
                .filter { $0.activationState == .foregroundActive }
                .first
                if let windowScene = windowScene as? UIWindowScene {
                    // 该window是全局变量
                    suspendWindow = PLSuspendWindow(windowScene: windowScene)
                    suspendWindow?.frame = PLSuspendViewConfig.suspendViewRect
                }
            } else {
                suspendWindow = PLSuspendWindow(frame: PLSuspendViewConfig.suspendViewRect)
            }
            suspendWindow?.fillModel(model: model)
            suspendWindow?.delegate = self
            suspendWindow?.isHidden = false
        }
//        let currentKeyWindow = getKeyWindows()
//        suspendWindow?.makeKeyAndVisible()
//        currentKeyWindow?.makeKeyAndVisible()

        /// 改变悬浮窗alpha
        changeSuspendViewAlpha(1, animated: true)
    }
    // 移除悬浮窗
    func removeSuspendView() {
        suspendWindow?.removeFromSuperview()
        suspendWindow = nil
    }
    // 悬浮窗透明度改变
    func changeSuspendViewAlpha(_ alpha: CGFloat, animated: Bool) {
        if animated {
            UIView.animate(withDuration: PLSuspendViewConfig.animateDuration) {
                self.suspendWindow?.alpha = alpha
            }
        } else {
            suspendWindow?.alpha = alpha
        }
    }
    
    func getKeyWindows() -> UIWindow? {
        var window:UIWindow? = nil
        if #available(iOS 13.0, *) {
            for windowScene:UIWindowScene in ((UIApplication.shared.connectedScenes as?  Set<UIWindowScene>)!) {
                if windowScene.activationState == .foregroundActive {
                    window = windowScene.windows.first
                  break
                }
            }
            return window
        }else{
            return  UIApplication.shared.keyWindow
        }
    }
}

// MARK: -  HXSuspendWindowDelegate
extension PLSuspendViewManager: PLSuspendWindowDelegate {
    // 悬浮窗点击事件
    func suspendWindowDidTap(_ suspendWindow: PLSuspendWindow) {
        // 弹出通话页面
//        XKVideoCallManager.shared.zoomInCallView()
    }
    
}

