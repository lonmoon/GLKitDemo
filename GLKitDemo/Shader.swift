//
//  Shader.swift
//  GLKitDemo
//
//  Created by Lonmoon on 2018/4/11.
//  Copyright © 2018年 Lonmoon. All rights reserved.
//

import Foundation
import GLKit

class Shader: NSObject {
    
    var programHandler: GLuint = 0
    
    var texture: GLuint = 0
    var modelViewMatrix = GLKMatrix4Identity
    var projectionMatrix = GLKMatrix4Identity
    var modelTransformation = GLKMatrix4Identity
    
    init(vertexShader: String, fragmentShader: String) {
        super.init()
        compile(vertexShader: vertexShader, fragmentShader: fragmentShader)
    }
    
    func compile(vertexShader: String, fragmentShader: String) {
        let vertexShaderHandler = compileShader(vertexShader, ofType: GLenum(GL_VERTEX_SHADER))
        let fragmentShaderHandler = compileShader(fragmentShader, ofType: GLenum(GL_FRAGMENT_SHADER))
        
        programHandler = glCreateProgram()
        glAttachShader(programHandler, vertexShaderHandler)
        glAttachShader(programHandler, fragmentShaderHandler)
        
        glBindAttribLocation(programHandler, VertexAttributes.position.rawValue, "a_Position")
        glBindAttribLocation(programHandler, VertexAttributes.color.rawValue, "a_Color")
        glBindAttribLocation(programHandler, VertexAttributes.texCoord.rawValue, "a_TexCoord")
        glLinkProgram(programHandler)
        
        glDeleteShader(vertexShaderHandler)
        glDeleteShader(fragmentShaderHandler)
        
        var linkSuccess : GLint = 0
        glGetProgramiv(programHandler, GLenum(GL_LINK_STATUS), &linkSuccess)
        if linkSuccess == GL_FALSE {
            var infoLength : GLsizei = 0
            let bufferLength : GLsizei = 1024
            glGetProgramiv(programHandler, GLenum(GL_INFO_LOG_LENGTH), &infoLength)
            
            let info : [GLchar] = Array(repeating: GLchar(0), count: Int(bufferLength))
            var actualLength : GLsizei = 0
            
            glGetProgramInfoLog(programHandler, bufferLength, &actualLength, UnsafeMutablePointer(mutating: info))
            NSLog(String(validatingUTF8: info)!)
            exit(1)
        }
    }
    
    func compileShader(_ shader: String, ofType type: GLenum) -> GLuint {
        guard let path = Bundle.main.path(forResource: shader, ofType: nil) else {
            NSLog("Shader file \"\(shader)\" does not exist.")
            exit(1)
        }
        
        do {
            let shaderHandler = glCreateShader(type)
            let shaderString = try NSString(contentsOfFile: path, encoding: String.Encoding.utf8.rawValue)
            var shaderStringLength = GLint(Int32(shaderString.length))
            var shaderCString = shaderString.utf8String
            glShaderSource(shaderHandler, 1, &shaderCString, &shaderStringLength)
            
            glCompileShader(shaderHandler)
            
            var compileSuccess: GLint = 0
            glGetShaderiv(shaderHandler, GLenum(GL_COMPILE_STATUS), &compileSuccess)
            if compileSuccess == GL_FALSE {
                var infoLength: GLsizei = 0
                let bufferLength: GLsizei = 1024
                glGetShaderiv(shaderHandler, GLenum(GL_INFO_LOG_LENGTH), &infoLength)
                
                let info: [GLchar] = Array(repeating: GLchar(0), count: Int(bufferLength))
                var actualLength: GLsizei = 0
                
                glGetShaderInfoLog(shaderHandler, bufferLength, &actualLength, UnsafeMutablePointer(mutating: info))
                NSLog(String(validatingUTF8: info)!)
                exit(1)
            }
            
            return shaderHandler
        } catch {
            NSLog("Shader file \"\(shader)\" can not be opened or encoding error.")
            exit(1)
        }
    }
    
    func prepareToDraw() {
        glUseProgram(programHandler)
        
        glBindTexture(GLenum(GL_TEXTURE_2D), texture)
        glUniformMatrix4fv(glGetUniformLocation(programHandler, "u_ModelViewMatrix"), 1, GLboolean(GL_FALSE), modelViewMatrix.array)
        glUniformMatrix4fv(glGetUniformLocation(programHandler, "u_ProjectionMatrix"), 1, GLboolean(GL_FALSE), projectionMatrix.array)
        glUniformMatrix4fv(glGetUniformLocation(programHandler, "u_ModelTransformation"), 1, GLboolean(GL_FALSE), modelTransformation.array)
    }
}
