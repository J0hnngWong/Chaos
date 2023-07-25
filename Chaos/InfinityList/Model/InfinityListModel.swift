//
//  InfinityListModel.swift
//  Chaos
//
//  Created by john on 2023/4/17.
//

import Foundation

//class InfinityListNode {
//    let id = UUID()
//    var title = ""
//}

class InfinityListNode {
    
    struct Info {
        var title: String
    }
    
    let id = UUID()
    let info: Info
    var subNodes: [InfinityListNode] = []
    
    init(info: Info) {
        self.info = info
    }
}
