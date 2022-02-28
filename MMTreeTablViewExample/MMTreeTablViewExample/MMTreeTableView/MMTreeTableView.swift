//
//  MMTreeTableView.swift
//  MMTreeTablViewExample
//
//  Created by JefferyYu on 2022/2/26.
//

import UIKit

protocol MMTreeTableViewDelegate {
    associatedtype T
    func nodeView(numberOfItems item: Int, model element: T, nodeView view: MMTreeTableView<T>) -> UIView
    func tableView(_ treeTableView: MMTreeTableView<T>, didSelectRowAt indexPath: IndexPath)
}

struct MMTreeDelegateThunk<E>: MMTreeTableViewDelegate {

    typealias T = E
    private let _nodeViewCustomerView: (Int, E ,MMTreeTableView<E>) -> UIView
    private let _nodeViewDidSelectRowAt: (MMTreeTableView<E>, IndexPath) -> ()

    init<Base: MMTreeTableViewDelegate>(base: Base) where Base.T == E {
        _nodeViewCustomerView = base.nodeView(numberOfItems:model:nodeView:)
        _nodeViewDidSelectRowAt = base.tableView(_:didSelectRowAt:)
    }

    func nodeView(numberOfItems item: Int, model element: E, nodeView view: MMTreeTableView<E>) -> UIView {
        return _nodeViewCustomerView(item, element, view)
    }

    func tableView(_ treeTableView: MMTreeTableView<E>, didSelectRowAt indexPath: IndexPath) {
        _nodeViewDidSelectRowAt(treeTableView, indexPath)
    }

}

public class MMTreeTableView<E>: UITableView, UITableViewDelegate, UITableViewDataSource { 

    var treeDelegate: MMTreeDelegateThunk<E>?
    var fileTree: MMFileTree<E>? { didSet { reloadDataSource() } }

    private var nodes = [MMNode<E>]()
    private let ID = "MMNodeCellIdentifier"

    public override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        initialization()
    }

    required init?(coder: NSCoder) { super.init(coder: coder); initialization() }

    // MARK: Private function

    private func initialization() {
        delegate = self
        dataSource = self
        estimatedRowHeight = 44
        register(MMNodeCell.self, forCellReuseIdentifier: ID)
    }


    private func reloadDataSource() {
        nodes.removeAll()
        nodes = preorder(fileTree?.root)
        reloadData()
    }

    @discardableResult
    private func preorder(_ root: MMNode<E>?, condition isOpen: Bool?=true) -> [MMNode<E>] {
        guard let root = root else { return nodes}
        nodes.append(root)
        for child in root.children where child.isOpen == true || child.depth == 1 {
            preorder(child)
        }
        return nodes
    }

    // MARK: UITableViewDataSource

    public func numberOfSections(in tableView: UITableView) -> Int { return 1 }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nodes.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ID, for: indexPath) as! MMNodeCell
        let node = nodes[indexPath.row]
        guard treeDelegate?.nodeView(numberOfItems: indexPath.row, model: node.element, nodeView: self) != nil else {
            cell.customerView = MMNodeView()
            (cell.customerView as! MMNodeView).title = "\(indexPath.row)"
            return cell
        }
        cell.customerView = treeDelegate?.nodeView(numberOfItems: indexPath.row, model: node.element, nodeView: self)
        return cell
    }

    // MARK: UITableViewDelegate
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        treeDelegate?.tableView(self, didSelectRowAt: indexPath)
        let node = nodes[indexPath.row]
        node.isOpen.toggle()
        reloadDataSource()
    }

}
