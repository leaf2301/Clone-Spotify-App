//
//  AlbumViewController.swift
//  Sportify.iOSAcademy
//
//  Created by Tran Hieu on 01/01/2024.
//

import UIKit

class AlbumViewController: UIViewController {
    
    private let album: Album
    
    init(album: Album) {
        self.album = album
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { index, _ -> NSCollectionLayoutSection in
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.7)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        ]
        return section
    }))
    
    private var viewModels = [AlbumCollectionViewCellViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = album.name
        view.backgroundColor = .systemBackground
        
        view.addSubview(collectionView)
        collectionView.register(AlbumTrackCollectionViewCell.self, forCellWithReuseIdentifier: AlbumTrackCollectionViewCell.id)
        collectionView.register(PlaylistHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PlaylistHeaderCollectionReusableView.id)
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        APICaller.shared.getAlbumDetails(for: album) { [weak self] result in
            DispatchQueue.main.sync {
                switch result {
                case .success(let model):
                    self?.viewModels = model.tracks.items.compactMap({ AlbumCollectionViewCellViewModel(name: $0.name, artistName: $0.artists.first?.name ?? "-") })
                    self?.collectionView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
}

extension AlbumViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumTrackCollectionViewCell.id, for: indexPath) as? AlbumTrackCollectionViewCell else {fatalError()}
        
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView()}
        
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: PlaylistHeaderCollectionReusableView.id, for: indexPath) as? PlaylistHeaderCollectionReusableView else { fatalError() }
        let headerViewModel = PlaylistHeaderViewViewModel(name: album.name, ownerName: album.artists.first?.name, description: "Release Date: \(String.formattedDate(string: album.release_date))", artworkURL: URL(string: album.images.first?.url ?? ""))
        header.configure(with: headerViewModel)
        header.delegate = self
        return header
    }
}

extension AlbumViewController: PlaylistHeaderCollectionReusableViewDelegate {
    func playlistHeaderCollectionReusableViewDelegateDidTapPlayAll(_ header: PlaylistHeaderCollectionReusableView) {
        
    }
}

