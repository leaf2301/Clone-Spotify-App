//
//  NewReleaseCollectionViewCell.swift
//  Sportify.iOSAcademy
//
//  Created by Tran Hieu on 26/12/2023.
//

import UIKit
import SDWebImage

class NewReleaseCollectionViewCell: UICollectionViewCell {
    static let id = "NewReleaseCollectionViewCell"
    
    private let albumCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let albumNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let numberOfTracksLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .thin)
        return label
    }()

    private let artistsNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .light)
        return label
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.clipsToBounds = true
        contentView.addSubviews(albumCoverImageView, albumNameLabel, artistsNameLabel, numberOfTracksLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize: CGFloat = contentView.height-10
        let albumLabelSize = albumNameLabel.sizeThatFits(.init(width: contentView.width-imageSize-10, height: contentView.height-10))
        artistsNameLabel.sizeToFit()
        numberOfTracksLabel.sizeToFit()

        albumCoverImageView.frame = .init(x: 5, y: 5, width: imageSize, height: imageSize)
        
        let albumLabelHeight = min(60, albumLabelSize.height)
        
        albumNameLabel.frame = .init(x: albumCoverImageView.right+10, y: 5, width: albumLabelSize.width, height: albumLabelHeight)

        artistsNameLabel.frame = .init(x: albumCoverImageView.right+10, y: albumNameLabel.bottom, width: contentView.width-albumCoverImageView.right-10, height: 30)

        numberOfTracksLabel.frame = .init(x: albumCoverImageView.right+10, y: contentView.bottom-44, width: numberOfTracksLabel.width, height: 44)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.albumNameLabel.text = nil
        self.artistsNameLabel.text = nil
        self.numberOfTracksLabel.text = nil
        self.albumCoverImageView.image = nil
    }
    
    public func configure(with viewModel: NewReleaseCellViewModel) {
        self.albumNameLabel.text = viewModel.name
        self.artistsNameLabel.text = viewModel.artistName
        self.numberOfTracksLabel.text = "Tracks: \(Int(viewModel.numberOfTracks))"
        self.albumCoverImageView.sd_setImage(with: viewModel.artworkURL)
    }
}
