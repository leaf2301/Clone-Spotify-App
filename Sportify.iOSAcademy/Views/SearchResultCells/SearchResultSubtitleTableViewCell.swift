//
//  SearchResultSubtitleTableViewCell.swift
//  Sportify.iOSAcademy
//
//  Created by Tran Hieu on 02/01/2024.
//

import UIKit

class SearchResultSubtitleTableViewCell: UITableViewCell {
    static let id = "SearchResultSubtitleTableViewCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(label, subtitleLabel, iconImageView)
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize = contentView.height - 10
        iconImageView.frame = .init(x: 10, y: 5, width: imageSize, height: imageSize)
        
        let labelHeight = contentView.height/2
        
        label.frame = .init(x: iconImageView.right+10, y: 0, width: contentView.width-iconImageView.right-15, height: labelHeight)
        
        subtitleLabel.frame = .init(x: iconImageView.right+10, y: label.bottom, width: contentView.width-iconImageView.right-15, height: labelHeight)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        label.text = nil
        subtitleLabel.text = nil
    }
    
    func configure(with viewModel: SearchResultSubtitleTableViewCellViewModel) {
        self.iconImageView.sd_setImage(with: viewModel.imageURL)
        self.label.text = viewModel.title
        self.subtitleLabel.text = viewModel.subtitle
    }
}
