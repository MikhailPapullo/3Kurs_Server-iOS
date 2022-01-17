//
//  FriendPhotoCollectionViewController.swift
//  NeVK
//
//  Created by Mikhail Papullo on 12/4/21.
//

import UIKit

class FriendPhotoCollectionViewController: UICollectionViewController {

    var friend: FriendModel?

    override func viewDidLoad() {
        super.viewDidLoad()
	}

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell",
                for: indexPath) as? PhotoCollectionViewCell
        else {
            return UICollectionViewCell() }
        
        cell.friendPicture.image = friend?.picture
        cell.friendPicture2.image = friend?.picture2
        cell.friendName.text = friend?.name
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "PhotoCarouselViewController") as?
                PhotoCarouselViewController else { return }
        if let images = friend?.friendPictures {
            vc.photos = images
        }
        vc.selectedPhoto = indexPath.item
        self.navigationController?.pushViewController(vc, animated: true)
        }
    }
