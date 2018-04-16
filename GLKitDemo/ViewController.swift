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
    
    var square: Square!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupContext()
        setupShader()
        square = Square()
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
    }
    
    func setupShader() {
        shader = Shader(vertexShader: "VertexShader.vsh", fragmentShader: "FragmentShader.fsh")
        shader.modelViewMatrix = GLKMatrix4MakeLookAt(0, 0, 10, 0, 0, 0, 0, 1, 0)
        shader.projectionMatrix = GLKMatrix4MakePerspective(.pi / 4,
                                                            Float(UIScreen.main.nativeBounds.width / UIScreen.main.nativeBounds.height),
                                                            0.1,
                                                            100)
    }
    
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glClearColor(0.6, 0.8, 1.0, 1.0)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
        
        square.transformation = GLKMatrix4RotateY(GLKMatrix4Identity, Float(2 * .pi * sin(timeSinceFirstResume)))
        square.drawWithShader(shader)
    }
}

