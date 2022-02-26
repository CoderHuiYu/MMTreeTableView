//
//  ViewController.swift
//  MMTreeTablViewExample
//
//  Created by JefferyYu on 2022/2/26.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        /** 需要解决的问题
                1. 依赖于数据源
                1. 依赖于数据源
         */

        view.addSubview(treeView, pinningEdges: .all, withInsets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }

    private lazy var treeView: MMTreeTableView = {
        let result = MMTreeTableView()
        result.backgroundColor = .red
        return result
    }()

}

