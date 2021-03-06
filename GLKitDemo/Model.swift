//
//  Model.swift
//  GLKitDemo
//
//  Created by Lonmoon on 2018/4/15.
//  Copyright © 2018年 Lonmoon. All rights reserved.
//

import GLKit

class Model: NSObject {
    var vertices: [Vertex] = []
    var indices: [GLubyte] = []
    var transformation = GLKMatrix4Identity
    
    var texture: GLuint = 0
    
    var vertexArray: GLuint = 0
    var vertexBuffer: GLuint = 0
    var elementArray: GLuint = 0
    
    init(vertices: [Vertex], indices: [GLubyte]) {
        super.init()
        self.vertices = vertices
        self.indices = indices
        setupModelData()
    }
    
    func drawWithShader(_ shader: Shader) {
        shader.texture = texture
        shader.modelTransformation = transformation
        
        shader.prepareToDraw()
        
        glBindVertexArray(vertexArray)
        glDrawElements(GLenum(GL_TRIANGLES), GLsizei(indices.count), GLenum(GL_UNSIGNED_BYTE), nil)
        glBindVertexArray(0)
    }
    
    func loadTexture(_ fileName: String) {
        let path = Bundle.main.path(forResource: fileName, ofType: nil)!
        let options = [
            GLKTextureLoaderOriginBottomLeft: true
        ]
        do {
            let info = try GLKTextureLoader.texture(withContentsOfFile: path, options: options as [String : NSNumber]?)
            texture = info.name
            glTexParameteri(GLenum(GL_TEXTURE_2D), GLenum(GL_TEXTURE_MIN_FILTER), GL_NEAREST);
            glTexParameteri(GLenum(GL_TEXTURE_2D), GLenum(GL_TEXTURE_MAG_FILTER), GL_NEAREST);
        } catch {
            NSLog("Texture load error.")
        }
    }
    
    private func setupModelData() {
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
        
        glEnableVertexAttribArray(VertexAttributes.color.rawValue)
        glVertexAttribPointer(VertexAttributes.color.rawValue, 4, GLenum(GL_FLOAT), GLboolean(GL_FALSE), GLsizei(MemoryLayout<Vertex>.size), BUFFER_OFFSET(3 * MemoryLayout<GLfloat>.size))
        
        glEnableVertexAttribArray(VertexAttributes.texCoord.rawValue)
        glVertexAttribPointer(VertexAttributes.texCoord.rawValue, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), GLsizei(MemoryLayout<Vertex>.size), BUFFER_OFFSET((3 + 4) * MemoryLayout<GLfloat>.size))
        
        // Unbind
        glBindVertexArray(0)
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), 0)
        glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), 0)
    }
    
    private func BUFFER_OFFSET(_ n: Int) -> UnsafeRawPointer? {
        return UnsafeRawPointer(bitPattern: n)
    }
}
