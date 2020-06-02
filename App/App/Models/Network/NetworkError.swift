//
//  NetworkError.swift
//  App
//
//  Created by Vinicius Hiroshi Higa on 02/06/20.
//  Copyright © 2020 Joao Flores. All rights reserved.
//

import Foundation

enum NetworkError: Error {

    case invalidParametersPassedIntoServer
    case invalidValuesReturnedFromServer
    case noConnectionAvailable
    case networkIsProbablyHavingProblems
    case serverError
    
}
