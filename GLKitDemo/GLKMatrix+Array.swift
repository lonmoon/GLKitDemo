//
//  GLKMatrix+Array.swift
//  GLKitDemo
//
//  Created by Lonmoon on 2018/4/16.
//  Copyright © 2018年 Lonmoon. All rights reserved.
//

import GLKit

extension GLKMatrix2 {
    var array: [Float] {
        return (0..<4).map { i in
            self[i]
        }
    }
}


extension GLKMatrix3 {
    var array: [Float] {
        return (0..<9).map { i in
            self[i]
        }
    }
}

extension GLKMatrix4 {
    var array: [Float] {
        return (0..<16).map { i in
            self[i]
        }
    }
}
