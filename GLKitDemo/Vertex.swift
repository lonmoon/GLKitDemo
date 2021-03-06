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
    case color = 1
    case texCoord = 2
}

struct Vertex {
    var x: GLfloat = 0.0
    var y: GLfloat = 0.0
    var z: GLfloat = 0.0
    
    var r: GLfloat = 0.0
    var g: GLfloat = 0.0
    var b: GLfloat = 0.0
    var a: GLfloat = 1.0
    
    var s: GLfloat = 0.0
    var t: GLfloat = 0.0
    
    init(_ x: GLfloat, _ y: GLfloat, _ z: GLfloat, _ r: GLfloat = 0, _ g: GLfloat = 0, _ b: GLfloat = 0, _ a: GLfloat = 1, _ s: GLfloat = 0, _ t: GLfloat = 0) {
        self.x = x
        self.y = y
        self.z = z
        
        self.r = r
        self.g = g
        self.b = b
        self.a = a
        
        self.s = s
        self.t = t
    }
}
