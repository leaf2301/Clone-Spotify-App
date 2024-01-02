//
//  PlaylistHeaderCollectionReusableView.swift
//  Sportify.iOSAcademy
//
//  Created by Tran Hieu on 01/01/2024.
//

import SDWebImage
import UIKit

protocol PlaylistHeaderCollectionReusableViewDelegate: AnyObject {
    func playlistHeaderCollectionReusableViewDelegateDidTapPlayAll(_ header: PlaylistHeaderCollectionReusableView)
}

class PlaylistHeaderCollectionReusableView: UICollectionReusableView {
    static let id = "PlaylistHeaderCollectionReusableView"
    
    weak var delegate: PlaylistHeaderCollectionReusableViewDelegate?
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        return label
    }()

    private let ownerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .light)
        return label
    }()
    
    private let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()

    private let playAllButton: UIButton = {
        let image = UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .regular))
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 30
        button.layer.masksToBounds = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubviews(nameLabel, descriptionLabel, ownerLabel, imageView, playAllButton)
        playAllButton.addTarget(self, action: #selector(playAllButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc func playAllButtonTapped() {
        delegate?.playlistHeaderCollectionReusableViewDelegateDidTapPlayAll(self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize: CGFloat = height/1.8
        imageView.frame = .init(x: (width-imageSize)/2, y: 20, width: imageSize, height: imageSize)
        
        nameLabel.frame = .init(x: 10, y: imageView.bottom, width: width-20, height: 44)
        descriptionLabel.frame = .init(x: 10, y: nameLabel.bottom, width: width-20, height: 44)
        ownerLabel.frame = .init(x: 10, y: descriptionLabel.bottom, width: width-20, height: 44)
        
        playAllButton.frame = .init(x: width-80, y: height-80, width: 60, height: 60)
    }
    
    func configure(with viewModel: PlaylistHeaderViewViewModel) {
        nameLabel.text = viewModel.name
        ownerLabel.text = viewModel.ownerName
        descriptionLabel.text = viewModel.description
        imageView.sd_setImage(with: viewModel.artworkURL)
    }
    
}
