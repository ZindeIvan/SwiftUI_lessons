//
//  Group.swift
//  VK_client
//
//  Created by Зинде Иван on 7/10/20.
//  Copyright © 2020 zindeivan. All rights reserved.
//

import Foundation

struct Group {
    let groupName : String
    let groupID : String
}

extension Group : Equatable {
    static func ==(lhs: Group, rhs: Group) -> Bool {
        return lhs.groupID == rhs.groupID
    }
}

extension Group : Comparable {
    static func < (lhs: Group, rhs: Group) -> Bool {
        lhs.groupID < rhs.groupID
    }
}
