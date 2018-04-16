//
//  Square.swift
//  GLKitDemo
//
//  Created by Lonmoon on 2018/4/15.
//  Copyright © 2018年 Lonmoon. All rights reserved.
//

import UIKit

fileprivate let vertexList: [Vertex] = [
    Vertex( 1.0, -1.0, 0.0, 1.0, 0.0, 0.0, 1, 0.0625, 0.0000),       // lower-right
    Vertex( 1.0,  1.0, 0.0, 0.0, 1.0, 0.0, 1, 0.0625, 0.0625),       // upper-right
    Vertex(-1.0,  1.0, 0.0, 0.0, 0.0, 1.0, 1, 0.0000, 0.0625),       // upper-left
    Vertex(-1.0, -1.0, 0.0, 1.0, 1.0, 1.0, 1, 0.0000, 0.0000)        // lower-left
]

fileprivate let indexList: [GLubyte] = [
    0, 1, 2,
    2, 3, 0
]

class Square: Model {
    override init(vertices: [Vertex] = vertexList, indices: [GLubyte] = indexList) {
        super.init(vertices: vertices, indices: indices)
        loadTexture("texture.png")
    }
}
