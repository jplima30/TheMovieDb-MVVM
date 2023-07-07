//
//  API.swift
//  MobileToYou
//
//  Created by jplima on 28/11/22.
//

import Foundation

enum APIConstants {
    static let baseURL = "https://api.themoviedb.org/3"

    enum Endpoints {
        case movieDetails
        case movieSimilar
        case genres
        
        var path: String {
            switch self {
            case .movieDetails:
                return "/movie/550?api_key=5fd457ad6807a2d7ff25180c9da87acd&language=pt-BR"
            case .movieSimilar:
                return "/movie/550/similar?api_key=5fd457ad6807a2d7ff25180c9da87acd&language=pt-BR"
            case .genres:
                return "/genre/movie/list?api_key=5fd457ad6807a2d7ff25180c9da87acd&language=pt-BR"
            }
        }
        
        var urlString: String {
            return APIConstants.baseURL + self.path
        }
    }
}
