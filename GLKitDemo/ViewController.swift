//
//  ViewController.swift
//  GLKitDemo
//
//  Created by Lonmoon on 2018/4/11.
//  Copyright © 2018年 Lonmoon. All rights reserved.
//

import GLKit

class ViewController: GLKViewController {
    
    var shader: Shader!

    var cube: Cube!
    
    var camera = Camera()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupContext()
        setupShader()
        cube = Cube()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupContext() {
        let glkView = view as! GLKView
        glkView.context = EAGLContext(api: .openGLES3)!
        
        // OpenGL ES functions require a current context.
        // This method must be used to select a context for the current thread before calling any OpenGL ES function. 
        EAGLContext.setCurrent(glkView.context)
        
        glEnable(GLenum(GL_DEPTH_TEST))
        glEnable(GLenum(GL_CULL_FACE))
        glCullFace(GLenum(GL_BACK))
    }
    
    func setupShader() {
        shader = Shader(vertexShader: "VertexShader.vsh", fragmentShader: "FragmentShader.fsh")
    }
    
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glClearColor(0.6, 0.8, 1.0, 1.0)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT))
        
        camera.position.y = Float(10 * sin(timeSinceFirstResume))
//        camera.target.y = Float(3 * sin(timeSinceFirstResume))
        shader.modelViewMatrix = camera.modelViewMatrix()
        shader.projectionMatrix = camera.projectionMatrix()

        cube.transformation = GLKMatrix4RotateY(GLKMatrix4Identity, Float(timeSinceFirstResume))
        cube.drawWithShader(shader)
    }
}

