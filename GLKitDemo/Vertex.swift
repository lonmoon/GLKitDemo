//
//  Vertex.swift
//  GLKitDemo
//
//  Created by Lonmoon on 2018/4/11.
//  Copyright © 2018年 Lonmoon. All rights reserved.
//

import Foundation
import GLKit

enum VertexAttributes: GLuint {
    case position = 0
}

struct Vertex {
    var x: GLfloat = 0.0
    var y: GLfloat = 0.0
    var z: GLfloat = 0.0
    
    init(_ x: GLfloat, _ y: GLfloat, _ z: GLfloat) {
        self.x = x
        self.y = y
        self.z = z
    }
}
