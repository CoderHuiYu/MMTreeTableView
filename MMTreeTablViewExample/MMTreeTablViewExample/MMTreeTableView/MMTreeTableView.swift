//
//  MMTreeTableView.swift
//  MMTreeTablViewExample
//
//  Created by JefferyYu on 2022/2/26.
//

import UIKit

public protocol MMTreeTableViewDelegate: AnyObject{

    func nodeView(numberOfItems item: Int, nodeView view: MMTreeTableView) -> UIView
    func tableView(_ treeTableView: MMTreeTableView, didSelectRowAt indexPath: IndexPath)
}

public class MMTreeTableView: UITableView {

    weak open var treeDelegate: MMTreeTableViewDelegate?
    private let ID = "MMNodeCellIdentifier"
    private var datas = [MMNode]()

    public override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        delegate = self
        dataSource = self
        register(MMNodeCell.self, forCellReuseIdentifier: ID)
        initialization()
    }

    required init?(coder: NSCoder) { super.init(coder: coder); initialization() }

    private func initialization() {

    }

    // MARK: Components 

    private lazy var tableView: UITableView = {
        let result = UITableView(frame: .zero, style: .plain)

        return result
    }()

}

extension MMTreeTableView: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ID, for: indexPath) as! MMNodeCell

        guard treeDelegate?.nodeView(numberOfItems: indexPath.row, nodeView: self) != nil else {
            cell.customerView = MMNodeView()
            (cell.customerView as! MMNodeView).title = "\(indexPath.row)"
            return cell
        }
        cell.customerView = treeDelegate?.nodeView(numberOfItems: indexPath.row, nodeView: self)
        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

}
