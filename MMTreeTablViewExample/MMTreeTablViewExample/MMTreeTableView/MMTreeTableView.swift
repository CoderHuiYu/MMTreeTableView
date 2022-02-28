//
//  MMTreeTableView.swift
//  MMTreeTablViewExample
//
//  Created by JefferyYu on 2022/2/26.
//

import UIKit

protocol MMTreeTableViewDelegate {
    associatedtype T
    func nodeView(numberOfItems item: Int, model: T, nodeView view: MMTreeTableView<T>) -> UIView
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
    var fileTree: MMFileTree<E>? {
        didSet {
            reloadData()
        }
    }

    private var nodes = [MMNode<E>]()
    private let ID = "MMNodeCellIdentifier"

    public override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        delegate = self
        dataSource = self
        estimatedRowHeight = 44
        register(MMNodeCell.self, forCellReuseIdentifier: ID)
        initialization()
    }

    required init?(coder: NSCoder) { super.init(coder: coder); initialization() }

    private func initialization() {

    }

    // MARK: Components

    public func numberOfSections(in tableView: UITableView) -> Int { return 1 }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fileTree?.childrenCount ?? 0
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ID, for: indexPath) as! MMNodeCell
        let model = nodes[indexPath.row] as! E
        guard treeDelegate?.nodeView(numberOfItems: indexPath.row, model: model, nodeView: self) != nil else {
            cell.customerView = MMNodeView()
            (cell.customerView as! MMNodeView).title = "\(indexPath.row)"
            return cell
        }
        cell.customerView = treeDelegate?.nodeView(numberOfItems: indexPath.row, model: model, nodeView: self)
        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        treeDelegate?.tableView(self, didSelectRowAt: indexPath)
    }

}
