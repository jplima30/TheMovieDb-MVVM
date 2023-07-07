//
//  ViewController.swift
//  MobileToYou
//
//  Created by jplima on 26/11/22.
//

import UIKit
import Kingfisher

final class MoviesViewController: UIViewController {
    
    private var allGenres: [Genre] = []
    private let viewModel: ViewModelMovies = ViewModelMovies()
    private var movies: [SimilarMovie]? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    private lazy var backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "background")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.alpha = 0.4
        return image
    }()
    
    private lazy var titleMovieLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.PrincipalMovieLargeTitle(.bold).font
        label.textColor = .white
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var voteCountLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.small(.regular).font
        label.textColor = .lightGray
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var popularityLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.small(.regular).font
        label.textColor = .lightGray
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var favoriteMovieButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.addTarget(self, action: #selector(likeClick), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(MovieCell.self, forCellReuseIdentifier: "MovieCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.fetchPrincipalMovie()
        viewModel.updateMovieInformation = { [weak self] response in
            self?.showMovieInformations(movie: response)
        }
        viewModel.updateMovieImage = { [weak self] urlResponse in
            self?.setMovieImage(url: urlResponse)
        }
        
        viewModel.updateGenres = { [weak self] genresResponse in
            self?.setGenres(allGenres: genresResponse)
        }
        
        viewModel.updateGenericError = { [weak self] in
            self?.showGenericError()
        }
        
        viewModel.updateAllMovies = { [weak self] allMoviesResponse in
            self?.setAllMovies(movies: allMoviesResponse)
        }
    }
    
    func setGenres(allGenres: [Genre]) {
        self.allGenres = allGenres
    }
    
    func setAllMovies(movies: [SimilarMovie]) {
        self.movies = movies
    }
    
    func showGenericError()  {
        self.movies = nil
    }
    
    func showMovieInformations(movie: Movie) {
        titleMovieLabel.text = movie.originalTitle
        voteCountLabel.text = movie.voteCount.kmFormatted
        popularityLabel.text = "\(movie.popularity.toString() ?? String()) views"
    }
    
    func setMovieImage(url: URL) {
        backgroundImage.kf.indicatorType = .activity
        backgroundImage.kf.setImage(with: url)
        
    }
    
    @objc private func likeClick() {
        if favoriteMovieButton.tag == 0 {
            favoriteMovieButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            favoriteMovieButton.tintColor = .red
            favoriteMovieButton.tag = 1
        } else {
            favoriteMovieButton.setImage(UIImage(systemName: "heart"), for: .normal)
            favoriteMovieButton.tintColor = .white
            favoriteMovieButton.tag = 0
        }
    }
    
    private func setupNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
    }
}

extension MoviesViewController {
    func buildHierarchy() {
        view.addSubview(backgroundImage)
        view.addSubview(titleMovieLabel)
        view.addSubview(voteCountLabel)
        view.addSubview(popularityLabel)
        view.addSubview(favoriteMovieButton)
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.heightAnchor.constraint(equalToConstant: 200),
            
            titleMovieLabel.topAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: -80),
            titleMovieLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleMovieLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            voteCountLabel.topAnchor.constraint(equalTo: titleMovieLabel.bottomAnchor),
            voteCountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            voteCountLabel.widthAnchor.constraint(equalToConstant: 50),
            
            popularityLabel.topAnchor.constraint(equalTo: titleMovieLabel.bottomAnchor),
            popularityLabel.leadingAnchor.constraint(equalTo: voteCountLabel.trailingAnchor),
            
            favoriteMovieButton.topAnchor.constraint(equalTo: titleMovieLabel.bottomAnchor),
            favoriteMovieButton.leadingAnchor.constraint(equalTo: popularityLabel.trailingAnchor),
            favoriteMovieButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: backgroundImage.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
    
    func applyAdditionalChanges() {
        setupNavigation()
    }
    
    func setupView() {
        buildHierarchy()
        setupConstraints()
        applyAdditionalChanges()
    }
}

extension MoviesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        guard let movieCell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieCell else {
            return UITableViewCell()
        }
        
        if let movie = movies?[indexPath.row] {
            movieCell.configure(movie: movie, allGenres: allGenres)
        }
        return movieCell
    }
    
}
