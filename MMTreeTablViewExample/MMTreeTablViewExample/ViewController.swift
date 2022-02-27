//
//  ViewController.swift
//  MMTreeTablViewExample
//
//  Created by JefferyYu on 2022/2/26.
//

import UIKit

class ViewController: UIViewController, MMTreeTableViewDelegate {
    typealias T = Model
    func nodeView(numberOfItems item: Int, nodeView view: MMTreeTableView<Model>) -> UIView {
        let result = UILabel()
        result.text = "\(item)"
        result.backgroundColor = .orange
        return result
    }

    func tableView(_ treeTableView: MMTreeTableView<Model>, didSelectRowAt indexPath: IndexPath) {

    }


    override func viewDidLoad() {
        super.viewDidLoad()

        constructionFileTree()
        view.addSubview(treeView, pinningEdges: .all, withInsets: UIEdgeInsets(top: 100, left: 10, bottom: 10, right: 10))
    }

    private func constructionFileTree() {

        let root = MMNode(element: Model(title: "root"))

        let node1 = MMNode(element: Model(title: "中国"), parent: root)
        let node1_1 = MMNode(element: Model(title: "北京"), parent: node1)
        let node1_2 = MMNode(element: Model(title: "上海"), parent: node1)
        let node1_3 = MMNode(element: Model(title: "深圳"), parent: node1)
        node1.add([ node1_1, node1_2, node1_3 ])

        let node2 = MMNode(element: Model(title: "美国"), parent: root)
        let node2_1 = MMNode(element: Model(title: "纽约"), parent: node2)
        let node2_2 = MMNode(element: Model(title: "华盛顿"), parent: node2)
        let node2_3 = MMNode(element: Model(title: "加利福利亚"), parent: node2)
        node2.add([ node2_1, node2_2, node2_3 ])


        root.add([ node1, node2 ])

        let fileTree = MMFileTree<Model>(root: root)
        treeView.fileTree = fileTree
    }

    private lazy var treeView: MMTreeTableView<Model> = {
        let result = MMTreeTableView<Model>()
        result.treeDelegate = MMTreeDelegateThunk(base: self)
        result.backgroundColor = .red
        return result
    }()

}

struct Model {
    var title: String
}
