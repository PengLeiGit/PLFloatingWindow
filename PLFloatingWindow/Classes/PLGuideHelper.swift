//
//  PLGuideHelper.swift
//  PLFloatingWindow
//
//  Created by 彭磊 on 2020/7/21.
//

import UIKit
import HandyJSON

public enum GuideType {
    case order // 下单
    case collection // 收藏
    case browse // 浏览
}

public class PLGuideHelper: NSObject {
    // MARK: - 初始化单例
    public static let shared = PLGuideHelper()
    private override init() {
        super.init()
    }
}

public extension PLGuideHelper {
    public func beginGuideRequest(type: GuideType, goodId: Int) {
        // 网络请求，请求成功后对应弹出对应的视图
        var model = PLGuideModel()
        model.subOrderNo = "0"
        PLSuspendViewManager.shared.addSuspendView(model: model)
    }
    
    func requestNewUserTask() {
        
    }
}



class PLGuideModel: NSObject, HandyJSON, Codable {
    required override init() {}
    
    var bizChannel: String = ""
    var bizCode: String = ""
    var bizType: String = ""
    var createTime: String = ""
    var feature: String = ""
    var inventoryId: String = ""
    var modifyTime: String = ""
    var orderNo: String = ""
    var subOrderNo: String = ""
    var subOrderStatus: Int = 0
}

