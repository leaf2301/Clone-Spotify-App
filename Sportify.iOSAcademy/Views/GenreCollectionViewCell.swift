//
//  GenreCollectionViewCell.swift
//  Sportify.iOSAcademy
//
//  Created by Tran Hieu on 02/01/2024.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {
    static let id = "GenreCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    private let colors: [UIColor] = [.systemPink, .systemBlue, .systemPurple, .systemOrange, .systemGreen, .systemRed, .systemYellow, .darkGray, .systemTeal]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.addSubviews(imageView, label)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        imageView.image = UIImage(systemName: "music.quarternote.3", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .regular))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.frame = .init(x: 10, y: contentView.height/2, width: contentView.width-20, height: contentView.height/2)
        imageView.frame = .init(x: contentView.width/2, y: 0, width: contentView.width/2, height: contentView.height/2)
    }
    
    func configure(with viewModel: CategoryCollectionViewCellViewModel) {
        self.label.text = viewModel.title
        self.imageView.sd_setImage(with: viewModel.artworkURL)
        self.contentView.backgroundColor = colors.randomElement()
    }
}
