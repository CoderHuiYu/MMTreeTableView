//
//  MMTreeTableView.swift
//  MMTreeTablViewExample
//
//  Created by JefferyYu on 2022/2/26.
//

import UIKit
public protocol MMTreeTableViewDelegate: AnyObject{

    func customerViewDataArrayCount() -> Int
    func customViewConfigure(numberOfItems item: Int, cycleView view: MMTreeTableView) -> UIView
    func collectionView(_ cycleView: MMTreeTableView, didSelectItemAt indexItem: Int)
}

public class MMTreeTableView: UIView {

    private let ID = "MMNodeCellIdentifier"
    private var dataSource = [MMNode]()
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialization()
        addSubview(tableView, pinningEdges: .all, withInsets: .zero)
    }

    required init?(coder: NSCoder) { super.init(coder: coder); initialization() }


    private func initialization() {

    }

    // MARK: Componets

    private lazy var tableView: UITableView = {
        let result = UITableView(frame: .zero, style: .plain)
        result.delegate = self
        result.dataSource = self
        result.register(MMNodeCell.self, forCellReuseIdentifier: ID)
        return result
    }()

}

extension MMTreeTableView: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ID, for: indexPath) as! MMNodeCell

        return cell
    }

}
