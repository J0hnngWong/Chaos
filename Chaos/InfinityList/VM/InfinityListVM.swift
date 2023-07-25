//
//  InfinityListVM.swift
//  Chaos
//
//  Created by john on 2023/4/17.
//

import Foundation

protocol InfinityListVMDelegate: AnyObject {
    func shouldRefresh()
}

class InfinityListVM {
    
    weak var delegate: InfinityListVMDelegate?
    
    var rootNode: InfinityListNode
    
    var dataSource: [InfinityListNode] {
        rootNode.subNodes
    }
    
    init(rootNode: InfinityListNode) {
        self.rootNode = rootNode
    }
    
    func appendNode(node: InfinityListNode) {
        rootNode.subNodes.append(node)
        delegate?.shouldRefresh()
    }
    
    func item(indexPath: IndexPath) -> InfinityListNode {
        guard indexPath.item < rootNode.subNodes.count else { fatalError() }
        return rootNode.subNodes[indexPath.item]
    }
}

extension InfinityListVM {
    class func empty() -> InfinityListVM {
        let node = InfinityListNode(info: .init(title: "root"))
        return InfinityListVM(rootNode: node)
    }
}
