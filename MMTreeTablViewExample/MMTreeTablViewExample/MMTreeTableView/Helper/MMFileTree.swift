//
//  MMFileTree.swift
//  MMTreeTablViewExample
//
//  Created by JefferyYu on 2022/2/26.
//

import UIKit

class MMFileTree<E> {
    /**
     核心是 子node 和父node之间的关系
     */
    var root: MMNode<E>

    required init(root: MMNode<E>) {
        self.root = root
    }

    public func add(_ node: MMNode<E>, to parent: MMNode<E>) {

    }

    public func delete(_ node: MMNode<E>, from parent: MMNode<E>? = nil) {

    }

    public func update(_ node: MMNode<E>, form parentOld: MMNode<E>, to parentNew: MMNode<E>) {

    }

    var childrenCount: Int {
        return root.childs.count
    }
}

public func += (lhs: MMNode<Any>, rhs: MMNode<Any>) { lhs.childs.append(rhs) }
public func += (lhs: MMNode<Any>, rhs: [MMNode<Any>]) { lhs.childs += rhs }

public class MMNode<E> {

    var element: E
    var parent: MMNode<E>?
    var childs = [MMNode<E>]()
    var isOpen: Bool
    var numberOfChildren: Int { get { childs.count } }

    init(element: E, parent: MMNode<E>? = nil, isOpen: Bool = false) {
        self.element = element
        self.parent = parent
        self.isOpen = isOpen
    }

    func add(_ node: MMNode<E>) {
        childs += node
    }

    func add(_ nodes: [MMNode<E>]) {
        childs += nodes
    }

    func child(at: Int) -> MMNode<E>? {
        if childs.count <= at { return nil }
        return childs[at]
    }
}

