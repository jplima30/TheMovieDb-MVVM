//
//  TodoMoviesCell.swift
//  MobileToYou
//
//  Created by jplima on 28/11/22.
//
import UIKit
import Kingfisher

final class MovieCell: UITableViewCell {
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        return blurView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [title, genres, yearMovieLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = Fonts.medium(.regular).font
        label.textColor = .white
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var genres: UILabel = {
        let label = UILabel()
        label.font = Fonts.small(.regular).font
        label.textColor = .lightGray
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var yearMovieLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.small(.regular).font
        label.textColor = .white
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var poster: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        buildHierarchy()
        setupConstraints()
        applyAdditionalChanges()
    }
    
    func configure(movie: SimilarMovie, allGenres: [Genre]) {
        title.text = movie.originalTitle
        genres.text = getJoinedGenres(movie, allGenres)
        yearMovieLabel.text = getYear(date: movie.releaseDate)
        let url = "https://image.tmdb.org/t/p/w185\(movie.posterPath)"
        guard let imageUrl = URL(string: url) else {
            return
        }
        
        poster.kf.indicatorType = .activity
        poster.kf.setImage(with: imageUrl)
        
    }
    
    private func getJoinedGenres(_ movie: SimilarMovie, _ genres: [Genre]) -> String {
        
        if !genres.isEmpty {
            let movieGenres:[Genre] = genres.filter({ (movie.genreIDS.contains($0.id )) })
            let genresDescription: [String] = movieGenres.map { $0.name }
            return genresDescription.compactMap{ $0 }.joined(separator: ", ")
        }
        
        return "Sem gênero listado"
    }
    
    private func getYear(date: String) -> String {
        let year = date.split(separator: "-")
        return String(year[0])
    }
}

extension MovieCell {
    func buildHierarchy() {
        contentView.addSubview(containerView)
        containerView.addSubview(blurView)
        containerView.addSubview(poster)
        containerView.addSubview(stackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            blurView.topAnchor.constraint(equalTo: containerView.topAnchor),
            blurView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            poster.topAnchor.constraint(equalTo: containerView.topAnchor),
            poster.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            poster.widthAnchor.constraint(equalToConstant: 100),
            poster.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            stackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            stackView.leadingAnchor.constraint(equalTo: poster.trailingAnchor, constant: 16)
            
        ])
        
        let heightConstraint = containerView.heightAnchor.constraint(equalToConstant: 150)
        heightConstraint.isActive = true
        heightConstraint.priority = UILayoutPriority.init(999)
    }
    
    func applyAdditionalChanges() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        selectionStyle = .none
    }
}
