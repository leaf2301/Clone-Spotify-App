//
//  AlbumTrackCollectionViewCell.swift
//  Sportify.iOSAcademy
//
//  Created by Tran Hieu on 02/01/2024.
//

import UIKit

class AlbumTrackCollectionViewCell: UICollectionViewCell {
    static let id = "AlbumTrackCollectionViewCell"
        
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
        contentView.addSubviews(trackNameLabel, artistNameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        trackNameLabel.frame = .init(x: 10, y: 0, width: contentView.width-15, height: contentView.height/2)
        
        artistNameLabel.frame = .init(x: 10, y: contentView.height/2, width: contentView.width-15, height: contentView.height/2)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.artistNameLabel.text = nil
        self.trackNameLabel.text = nil
    }
    
    public func configure(with viewModel: AlbumCollectionViewCellViewModel) {
        self.artistNameLabel.text = viewModel.artistName
        self.trackNameLabel.text = viewModel.name
    }
}
