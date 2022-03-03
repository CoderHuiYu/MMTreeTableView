//
//  MMNodeView.swift
//  MMTreeTablViewExample
//
//  Created by JefferyYu on 2022/2/26.
//

import UIKit

class MMNodeView: UIView {

    var title: String {
        get { titleLabel.text ?? "" }
        set { titleLabel.text = newValue }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialization()
    }

    required init?(coder: NSCoder) { super.init(coder: coder); initialization() }

    private func initialization() {
        addSubview(titleLabel, pinningEdges: .all, withInsets: .zero)
    }

    // MARK: Components

    private lazy var titleLabel: UILabel = {
        let result = UILabel()
        result.textColor = .black
        result.numberOfLines = 1
        return result
    }()
}
