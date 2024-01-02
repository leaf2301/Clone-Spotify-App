//
//  RecommendedTrackCollectionViewCell.swift
//  Sportify.iOSAcademy
//
//  Created by Tran Hieu on 26/12/2023.
//

import UIKit

class RecommendedTrackCollectionViewCell: UICollectionViewCell {
    static let id = "RecommendedTrackCollectionViewCell"
    
    private let albumCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let trackNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()

    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .thin)
        return label
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        contentView.backgroundColor = .secondarySystemBackground
        contentView.clipsToBounds = true
        contentView.addSubviews(albumCoverImageView, trackNameLabel, artistNameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        albumCoverImageView.frame = .init(x: 5, y: 2, width: contentView.height-4, height: contentView.height-4)
        
        trackNameLabel.frame = .init(x: albumCoverImageView.right+10, y: 0, width: contentView.width-albumCoverImageView.right-15, height: contentView.height/2)
        
        artistNameLabel.frame = .init(x: albumCoverImageView.right+10, y: contentView.height/2, width: contentView.width-albumCoverImageView.right-15, height: contentView.height/2)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.artistNameLabel.text = nil
        self.trackNameLabel.text = nil
        self.albumCoverImageView.image = nil
    }
    
    public func configure(with viewModel: RecommendedTrackCellViewModel) {
        self.artistNameLabel.text = viewModel.artistName
        self.trackNameLabel.text = viewModel.name
        self.albumCoverImageView.sd_setImage(with: viewModel.artworkURL)
    }
}
