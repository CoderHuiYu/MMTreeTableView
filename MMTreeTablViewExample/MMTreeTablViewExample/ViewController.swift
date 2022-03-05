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

        constructionFileTree()

        view.addSubview(treeView, pinningEdges: .all, withInsets: .zero)
    }

    ///  // Building data Structures（构建数据结构）
    private func constructionFileTree() {

        let root = MMNode(element: Model(title: "世界国家"))

        let node1 = MMNode(element: Model(title: "中国"))
        let node1_1 = MMNode(element: Model(title: "杭州"))
        let node1_2 = MMNode(element: Model(title: "上海"))
        let node1_3 = MMNode(element: Model(title: "深圳"))
        node1.add([ node1_1, node1_2, node1_3 ])


        let nodeCity = MMNode(element: Model(title: "北京"), parent: node1)
        let nodeCity_1 = MMNode(element: Model(title: "朝阳"), parent: nodeCity)
        let nodeCity_2 = MMNode(element: Model(title: "海淀"), parent: nodeCity)
        let nodeCity_3 = MMNode(element: Model(title: "东城"), parent: nodeCity)

        nodeCity.add([ nodeCity_1, nodeCity_2, nodeCity_3 ])
        node1.add(nodeCity)

        let node2 = MMNode(element: Model(title: "美国"), parent: root)
        let node2_1 = MMNode(element: Model(title: "纽约"), parent: node2)
        let node2_2 = MMNode(element: Model(title: "华盛顿"), parent: node2)
        let node2_3 = MMNode(element: Model(title: "加利福利亚"), parent: node2)
        node2.add([ node2_1, node2_2, node2_3 ])

        let node3 = MMNode(element: Model(title: "英国"), parent: root)
        let node3_1 = MMNode(element: Model(title: "伦敦"), parent: node3)
        let node3_2 = MMNode(element: Model(title: "爱丁堡"), parent: node3)
        let node3_3 = MMNode(element: Model(title: "剑桥"), parent: node3)
        node3.add([ node3_1, node3_2, node3_3 ])
        
        root.add([ node1, node2, node3 ])

        let fileTree = MMFileTree<Model>(root: root)
        treeView.fileTree = fileTree
    }

    private lazy var treeView: MMTreeTableView<Model> = {
        let expand = Option.expandForever(true)
        let startDepth = Option.startDepth(1)
        let indentation = Option.indentationWidth(30.0)

        let result = MMTreeTableView<Model>(options: [ startDepth, indentation ], frame: .zero, style: .plain)
        result.treeDelegate = MMTreeDelegateThunk(base: self)
        result.backgroundColor = .green.withAlphaComponent(0.2)
        return result
    }()

}

extension ViewController: MMTreeTableViewDelegate {

    typealias T = Model
    func nodeView(numberOfItems item: Int, model element: Model, nodeView view: MMTreeTableView<Model>) -> UIView {
        let result = UILabel()
        result.heightAnchor.constraint(equalToConstant: 50).isActive = true
        result.text = "\(element.title)"
        return result
    }

    func tableView(_ treeTableView: MMTreeTableView<Model>, didSelectRowAt indexPath: IndexPath) {
        print("----\(indexPath.item)----")
    }

}

struct Model {
    var title: String
}
