//
//  MoviesService.swift
//  MobileToYou
//
//  Created by jplima on 28/11/22.
//

import Foundation

final class MoviesService {
    
    // MARK: Properties

    private let service: ServiceProvider
    
    // MARK: Init's

    init(service: ServiceProvider = Service()) {
        self.service = service
    }
    
    func fetchMovie(result: @escaping (Result<Movie, ServiceError>) -> Void) {
        service.makeRequest(endpoint: .movieDetails, parameters: nil) { response in
            DispatchQueue.main.async {
                result(response)
            }
        }
    }
    
    func fetchList(result:  @escaping(Result<SimilarMovies, ServiceError>) -> Void) {
        service.makeRequest(endpoint: .movieSimilar, parameters: nil) { response in
            DispatchQueue.main.async {
                result(response)
            }
        }
    }
    
    func fetchGenres(result: @escaping(Result<Genres, ServiceError>) -> Void) {
        service.makeRequest(endpoint: .genres, parameters: nil) { response in
            DispatchQueue.main.async {
                result(response)
            }
        }
    }
    
}

