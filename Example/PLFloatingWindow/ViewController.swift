//
//  ViewController.swift
//  PLFloatingWindow
//
//  Created by 1248667206@qq.com on 07/21/2020.
//  Copyright (c) 2020 1248667206@qq.com. All rights reserved.
//

import UIKit
import PLFloatingWindow

class ViewController: UIViewController {
    
    lazy var btn: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        btn.backgroundColor = .cyan
        btn.setTitle("点一下", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(btn)
        btn.frame = CGRect(x: 10, y: 10, width: 80, height: 80)
    }
    
    @objc func btnClick() {
        PLGuideHelper.shared.beginGuideRequest(type: .collection, goodId: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

