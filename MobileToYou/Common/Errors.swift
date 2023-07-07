//
//  Errors.swift
//  MobileToYou
//
//  Created by jplima on 28/11/22.
//

import Foundation

enum ServiceError: Error {
    case parseError
    case statusCode(Int)
    case badRequest
}
