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
    var vertexArray: GLuint = 0
    var elementArray: GLuint = 0
    
    
    let vertices : [Vertex] = [
        Vertex( 0.0,  1.0, 0.0),       // TOP
        Vertex(-1.0,  0.0, 0.0),       // LEFT
        Vertex( 1.0,  0.0, 0.0),       // RIGHT
        Vertex( 0.0, -1.0, 0.0)        // BOTTOM
    ]
    
    let indices : [GLubyte] = [
        0, 1, 2,
        2, 1, 3
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupContext()
        setupShader()
        setupVertexData()
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
    
    func setupVertexData() {
        // Use VAO to mintain vertex data.
        glGenVertexArrays(1, &vertexArray)
        glBindVertexArray(vertexArray)
        
        glGenBuffers(1, &vertexBuffer)
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), vertexBuffer)
        glBufferData(GLenum(GL_ARRAY_BUFFER), vertices.count * MemoryLayout<Vertex>.size, vertices, GLenum(GL_STATIC_DRAW))
        
        glGenBuffers(1, &elementArray)
        glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), elementArray)
        glBufferData(GLenum(GL_ELEMENT_ARRAY_BUFFER), indices.count * MemoryLayout<GLubyte>.size, indices, GLenum(GL_STATIC_DRAW))
        
        glEnableVertexAttribArray(VertexAttributes.position.rawValue)
        glVertexAttribPointer(VertexAttributes.position.rawValue, 3, GLenum(GL_FLOAT), GLboolean(GL_FALSE), GLsizei(MemoryLayout<Vertex>.size), nil)
        
        // Unbind
        glBindVertexArray(0)
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), 0)
        glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), 0)
    }
    
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glClearColor(0.6, 0.8, 1.0, 1.0)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
        
        shader.prepareToDraw()
        
        glBindVertexArray(vertexArray)
        glDrawElements(GLenum(GL_TRIANGLES), GLsizei(indices.count), GLenum(GL_UNSIGNED_BYTE), nil)
        glBindVertexArray(0)
    }
}

