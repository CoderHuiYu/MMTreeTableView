//
//  MMNode.swift
//  MMTreeTablViewExample
//
//  Created by JefferyYu on 2022/2/26.
//

import UIKit

class MMTreeNode<E> {

    

    private class MMNode<E> {

        var element: E
        var parent: MMNode<E>
        var childs: [MMNode<E>]?
        var isOpen: Bool
        var numberOfChildren: Int = 0

        init(element: E, parent: MMNode<E>, isOpen: Bool = false) {
            self.element = element
            self.parent = parent
            self.isOpen = isOpen
        }

        func child(at: Int) -> MMNode<E>? {
            guard let childs = childs else  { return nil }
            if childs.count <= at { return nil }
            return childs[at]
        }
    }

}



