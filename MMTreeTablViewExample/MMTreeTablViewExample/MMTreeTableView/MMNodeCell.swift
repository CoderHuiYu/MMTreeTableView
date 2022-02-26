//
//  MMNodeCell.swift
//  MMTreeTablViewExample
//
//  Created by JefferyYu on 2022/2/26.
//

import UIKit

class MMNodeCell: UITableViewCell {

    public var customerView: UIView? {
        didSet {
            if customerView != oldValue {
                handleRowChanged(oldValue: oldValue)
            }
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder); initialize()
    }

    private func initialize() {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: leftAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor).with(priority: .pseudoRequired),
            contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])
    }

    // MARK: Updating
    private func handleRowChanged(oldValue: UIView?) {
        // Remove old
        oldValue?.removeFromSuperview()
        // Add new
        if let view = customerView {
            view.removeFromSuperview()
            contentView.addSubview(view, pinningEdges: .all, withInsets: .zero)
        }
    }

}
