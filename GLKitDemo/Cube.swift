//
//  Cube.swift
//  GLKitDemo
//
//  Created by Lonmoon on 2018/4/16.
//  Copyright © 2018年 Lonmoon. All rights reserved.
//

import GLKit

fileprivate let vertexList: [Vertex] = [
    
    // Front
    Vertex( 1, -1, 1,  1, 0, 0, 1, 0.0625, 0.0625), // 0
    Vertex( 1,  1, 1,  0, 1, 0, 1, 0.0625, 0.1250), // 1
    Vertex(-1,  1, 1,  0, 0, 1, 1, 0.0000, 0.1250), // 2
    Vertex(-1, -1, 1,  0, 0, 0, 1, 0.0000, 0.0625), // 3
    
    // Back
    Vertex(-1, -1, -1, 0, 0, 1, 1, 0.0625, 0.0625), // 4
    Vertex(-1,  1, -1, 0, 1, 0, 1, 0.0625, 0.1250), // 5
    Vertex( 1,  1, -1, 1, 0, 0, 1, 0.0000, 0.1250), // 6
    Vertex( 1, -1, -1, 0, 0, 0, 1, 0.0000, 0.0625), // 7
    
    // Left
    Vertex(-1, -1,  1, 1, 0, 0, 1, 0.0625, 0.0625), // 8
    Vertex(-1,  1,  1, 0, 1, 0, 1, 0.0625, 0.1250), // 9
    Vertex(-1,  1, -1, 0, 0, 1, 1, 0.0000, 0.1250), // 10
    Vertex(-1, -1, -1, 0, 0, 0, 1, 0.0000, 0.0625), // 11
    
    // Right
    Vertex( 1, -1, -1, 1, 0, 0, 1, 0.0625, 0.0625), // 12
    Vertex( 1,  1, -1, 0, 1, 0, 1, 0.0625, 0.1250), // 13
    Vertex( 1,  1,  1, 0, 0, 1, 1, 0.0000, 0.1250), // 14
    Vertex( 1, -1,  1, 0, 0, 0, 1, 0.0000, 0.0625), // 15
    
    // Top
    Vertex( 1,  1,  1, 1, 0, 0, 1, 0.0625, 0.1250), // 16
    Vertex( 1,  1, -1, 0, 1, 0, 1, 0.0625, 0.1875), // 17
    Vertex(-1,  1, -1, 0, 0, 1, 1, 0.0000, 0.1875), // 18
    Vertex(-1,  1,  1, 0, 0, 0, 1, 0.0000, 0.1250), // 19
    
    // Bottom
    Vertex( 1, -1, -1, 1, 0, 0, 1, 0.0625, 0.0000), // 20
    Vertex( 1, -1,  1, 0, 1, 0, 1, 0.0625, 0.0625), // 21
    Vertex(-1, -1,  1, 0, 0, 1, 1, 0.0000, 0.0625), // 22
    Vertex(-1, -1, -1, 0, 0, 0, 1, 0.0000, 0.0000), // 23
    
]

fileprivate let indexList: [GLubyte] = [
    
    // Front
    0, 1, 2,
    2, 3, 0,
    
    // Back
    4, 5, 6,
    6, 7, 4,
    
    // Left
    8, 9, 10,
    10, 11, 8,
    
    // Right
    12, 13, 14,
    14, 15, 12,
    
    // Top
    16, 17, 18,
    18, 19, 16,
    
    // Bottom
    20, 21, 22,
    22, 23, 20
]

class Cube: Model {
    override init(vertices: [Vertex] = vertexList, indices: [GLubyte] = indexList) {
        super.init(vertices: vertices, indices: indices)
        loadTexture("texture.png")
    }
}
