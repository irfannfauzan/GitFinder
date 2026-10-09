//
//  GithubDetailViewController.swift
//  GitFinder
//
//  Created by Vokal-Ican on 09/10/26.
//

import UIKit

protocol GithubDetailViewProtocol: AnyObject {
    func showLoading()
    func showDetail(_ detail: Github)
    func showError(_ message: String?)
}

class GithubDetailViewController: UIViewController {
    
    var presenter: GithubDetailPresenterProtocol!
    
    private var imageLoadTask: Task<Void, Never>?

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var openButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Open on GitHub"
        config.cornerStyle = .capsule
        config.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 24, bottom: 12, trailing: 24)
        let button = UIButton(configuration: config)
        button.addTarget(self, action: #selector(didTapOpen), for: .touchUpInside)
        return button
    }()
    
    private let imageViews: UIImageView = {
        let images = UIImageView()
        images.contentMode = .scaleAspectFit
        images.translatesAutoresizingMaskIntoConstraints = false
        images.heightAnchor.constraint(equalToConstant: 50).isActive = true
        images.widthAnchor.constraint(equalToConstant: 50).isActive = true
        return images
    }()

    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [imageViews, titleLabel, subtitleLabel, openButton])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .gray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(stack)
        view.addSubview(loadingIndicator)
        view.addSubview(statusLabel)
        titleLabel.text = "Title"
        subtitleLabel.text = "Subtitle"

        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -24),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),

           statusLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
           statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
           statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
        ])
        
        presenter.viewDidLoad()
    }
    
    @objc func didTapOpen() {
        presenter.didTapOpenProfile()
    }
    
    private func loadImage(from url: URL?) {
        imageLoadTask?.cancel()
        guard let url else { return }

        imageLoadTask = Task { [weak self] in
            guard let (data, _) = try? await URLSession.shared.data(from: url),
                  let image = UIImage(data: data),
                  !Task.isCancelled else { return }
            await MainActor.run {
                self?.imageViews.image = image
            }
        }
    }
}

extension GithubDetailViewController: GithubDetailViewProtocol {
    func showLoading(){
        stack.isHidden = true
        statusLabel.isHidden = true
        loadingIndicator.startAnimating()
    }
    
    func showDetail(_ detail: Github) {
        loadingIndicator.stopAnimating()
        statusLabel.isHidden = true
        stack.isHidden = false
        titleLabel.text = detail.login
        subtitleLabel.text = detail.nodeId
        loadImage(from: detail.avatarUrl)
    }
    
    func showError(_ message: String?) {
        loadingIndicator.stopAnimating()
        stack.isHidden = true
        statusLabel.isHidden = false
        statusLabel.text = message ?? "Something went wrong."
    }
}
