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
        backgroundColor = .clear
        selectionStyle = .none
    }

    required init?(coder: NSCoder) { super.init(coder: coder) }

    // MARK: Updating
    private func handleRowChanged(oldValue: UIView?) {
        // Remove old
        oldValue?.removeFromSuperview()
        // Add new
        if let view = customerView {
            view.removeFromSuperview()
            contentView.addSubview(view, pinningEdges: .all, withInsets: UIEdgeInsets(top: 0, left: CGFloat(indentationLevel) * indentationWidth, bottom: 0, right: 0))
        }
    }
}
