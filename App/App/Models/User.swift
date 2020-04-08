//
//  User.swift
//  App
//
//  Created by Vinicius Hiroshi Higa on 07/04/20.
//  Copyright © 2020 Joao Flores. All rights reserved.
//

import Foundation

class User {
    
    // Default properties
    private(set) var name: String
    private(set) var meta: String
    
    
    /// Initializes an User instance with default name and meta
    init() {
        self.name = "Usuário"
        self.meta = "Melhorar qualidade da minha alimentação"
    }
    
    
    
    /// Initializes an User instance with certain name and meta
    /// - Parameters:
    ///   - name: Desired name
    ///   - meta: Desired meta
    init(name: String, meta: String) {
        self.name = name
        self.meta = meta
    }
    
}
