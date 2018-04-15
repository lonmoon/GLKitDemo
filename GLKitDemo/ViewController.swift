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
    }
    
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glClearColor(0.6, 0.8, 1.0, 1.0)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
        
        square.drawWithShader(shader)
    }
}

