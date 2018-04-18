//
//  Camera.swift
//  GLKitDemo
//
//  Created by Lonmoon on 2018/4/18.
//  Copyright © 2018年 Lonmoon. All rights reserved.
//

import GLKit

class Camera: NSObject {
    var position: GLKVector3
    var target: GLKVector3
    var fovyRadians: Float
    var aspect: Float
    var near: Float
    var far: Float
    var up = GLKVector3Make(0, 1, 0)
    
    init(position: GLKVector3 = GLKVector3Make(0, 0, 10),
         target: GLKVector3 = GLKVector3Make(0, 0, 0),
         fovyRadians: Float = .pi / 4,
         aspect: Float = 9 / 16,
         near: Float = 0.1,
         far: Float = 100) {
        self.position = position
        self.target = target
        self.fovyRadians = fovyRadians
        self.aspect = aspect
        self.near = near
        self.far = far
        
        super.init()
    }
    
    func modelViewMatrix() -> GLKMatrix4 {
        return GLKMatrix4MakeLookAt(position.x, position.y, position.z, target.x, target.y, target.z, up.x, up.y, up.z)
    }
    
    func projectionMatrix() -> GLKMatrix4 {
        return GLKMatrix4MakePerspective(fovyRadians, aspect, near, far)
    }
}
