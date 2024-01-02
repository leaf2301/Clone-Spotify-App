//
//  FeaturedPlaylistCollectionViewCell.swift
//  Sportify.iOSAcademy
//
//  Created by Tran Hieu on 26/12/2023.
//

import UIKit
import SDWebImage

class FeaturedPlaylistCollectionViewCell: UICollectionViewCell {
    static let id = "FeaturedPlaylistCollectionViewCell"
    
    private let playlistCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 4
        return imageView
    }()
    
    private let playlistNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()

    private let creatorNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .thin)
        return label
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.clipsToBounds = true
        contentView.addSubviews(playlistCoverImageView, playlistNameLabel, creatorNameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        creatorNameLabel.frame = .init(x: 3, y: contentView.height-30, width: contentView.width-6, height: 30)
        playlistNameLabel.frame = .init(x: 3, y: contentView.height-60, width: contentView.width-6, height: 30)
        
        let imageSize = contentView.height - 70
        playlistCoverImageView.frame = .init(x: (contentView.width-imageSize)/2, y: 3, width: imageSize, height: imageSize)

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.creatorNameLabel.text = nil
        self.playlistNameLabel.text = nil
        self.playlistCoverImageView.image = nil
    }
    
    public func configure(with viewModel: FeaturedPlaylistCellViewModel) {
        self.creatorNameLabel.text = viewModel.creatorName
        self.playlistNameLabel.text = viewModel.name
        self.playlistCoverImageView.sd_setImage(with: viewModel.artworkURL)
    }
}
