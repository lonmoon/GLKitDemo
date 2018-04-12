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
    
    var vertexBuffer : GLuint = 0
    
    let vertices : [Vertex] = [
        Vertex( 0.0,  0.25, 0.0),    // TOP
        Vertex(-0.5, -0.25, 0.0),    // LEFT
        Vertex( 0.5, -0.25, 0.0),    // RIGHT
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupContext()
        setupShader()
        setupVertexBuffer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupContext() {
        let glkView = view as! GLKView
        glkView.context = EAGLContext(api: .openGLES3)!
        
        // OpenGL ES functions require a current context
        // This method must be used to select a context for the current thread before calling any OpenGL ES function. 
        EAGLContext.setCurrent(glkView.context)
    }
    
    func setupShader() {
        shader = Shader(vertexShader: "VertexShader.vsh", fragmentShader: "FragmentShader.fsh")
    }
    
    func setupVertexBuffer() {
        glGenBuffers(GLsizei(1), &vertexBuffer)
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), vertexBuffer)
        glBufferData(GLenum(GL_ARRAY_BUFFER), vertices.count * MemoryLayout<Vertex>.size, vertices, GLenum(GL_STATIC_DRAW))
    }
    
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glClearColor(0.6, 0.8, 1.0, 1.0)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
        
        shader.prepareToDraw()
        
        glEnableVertexAttribArray(0)
        glVertexAttribPointer(0, 3, GLenum(GL_FLOAT), GLboolean(GL_FALSE), GLsizei(MemoryLayout<Vertex>.size), nil)

        glBindBuffer(GLenum(GL_ARRAY_BUFFER), vertexBuffer)
        glDrawArrays(GLenum(GL_TRIANGLES), 0, 3)
    }
}

