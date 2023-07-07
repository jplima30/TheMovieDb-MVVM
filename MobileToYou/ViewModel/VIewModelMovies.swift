//
//  VIewModelMovies.swift
//  MobileToYou
//
//  Created by Joao Paulo Lima Silva on 27/12/22.
//

import Foundation

class ViewModelMovies {
    
    private let service: MoviesService = MoviesService()
    var updateMovieInformation: ((_ movie: Movie) -> Void)?
    var updateMovieImage: ((_ url: URL) -> Void)?
    var updateGenres: ((_ allGenres: [Genre]) -> Void)?
    var updateGenericError: (() -> Void)?
    var updateAllMovies: ((_ movies: [SimilarMovie]) -> Void)?
    
    func fetchPrincipalMovie() {
        service.fetchMovie() { [weak self] result in
            switch result {
            case .success(let response):
                self?.updateMovieInformation?(response)
                let urlString = "https://image.tmdb.org/t/p/w185\(response.posterPath)"
                guard let imageUrl = URL(string: urlString) else {
                    return
                }
                
                self?.updateMovieImage?(imageUrl)
                self?.fetchGenres()
            case .failure:
                self?.updateGenericError?()
            }
        }
    }
    
    private func fetchGenres() {
        service.fetchGenres { [weak self] result in
            switch result {
            case .success(let response):         
                self?.updateGenres?(response.genres)
                self?.fetchSimilarMovies()
            case .failure:
                self?.updateGenericError?()
            }
        }
    }
    
    private func fetchSimilarMovies() {
        service.fetchList { [weak self] result in
            switch result {
            case .success(let response):
                self?.updateAllMovies?(response.results)
            case .failure:
                self?.updateGenericError?()
                
            }
        }
    }
    
}
