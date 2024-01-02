//
//  PlaylistViewController.swift
//  Sportify.iOSAcademy
//
//  Created by Tran Hieu on 25/12/2023.
//

import UIKit

class PlaylistViewController: UIViewController {

    private let playlist: Playlist
    
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
    
    
    init(playlist: Playlist) {
        self.playlist = playlist
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private var viewModels = [RecommendedTrackCellViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = playlist.name
        view.backgroundColor = .systemBackground
        
        view.addSubview(collectionView)
        collectionView.register(RecommendedTrackCollectionViewCell.self, forCellWithReuseIdentifier: RecommendedTrackCollectionViewCell.id)
        collectionView.register(PlaylistHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PlaylistHeaderCollectionReusableView.id)
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        APICaller.shared.getPlaylistDetails(for: playlist, completion: { [weak self] result in
            DispatchQueue.main.sync {
                switch result {
                case .success(let model):
                    self?.viewModels = model.tracks.items.compactMap({ RecommendedTrackCellViewModel(name: $0.track.name, artistName: $0.track.artists.first?.name ?? "-", artworkURL: URL(string: $0.track.album?.images.first?.url ?? "")) })
                    self?.collectionView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        })
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
    }
    
    @objc func didTapShare() {
        guard let url = URL(string: playlist.external_urls["spotify"] as? String ?? "" ) else { return }
        let vc = UIActivityViewController(activityItems: [url], applicationActivities: [])
        
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
}

extension PlaylistViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendedTrackCollectionViewCell.id, for: indexPath) as? RecommendedTrackCollectionViewCell else {fatalError()}
        
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView()}
        
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: PlaylistHeaderCollectionReusableView.id, for: indexPath) as? PlaylistHeaderCollectionReusableView else { fatalError() }
        let headerViewModel = PlaylistHeaderViewViewModel(name: playlist.name, ownerName: playlist.owner.display_name, description: playlist.description, artworkURL: URL(string: playlist.images.first?.url ?? ""))
        header.configure(with: headerViewModel)
        header.delegate = self
        return header
    }
}

extension PlaylistViewController: PlaylistHeaderCollectionReusableViewDelegate {
    func playlistHeaderCollectionReusableViewDelegateDidTapPlayAll(_ header: PlaylistHeaderCollectionReusableView) {
        
    }
}
