//
//  ProfileFilterView.swift
//  TwitterClone2
//
//  Created by Ensar Yasin Karaköse on 7.03.2023.
//

import UIKit

private let filterIdentifier = "ProfileFilterCell"

protocol ProfileFilterViewDelegate : AnyObject {
    func filterView(_ view: ProfileFilterView, didSelect indexPath: IndexPath)
}

final class ProfileFilterView : UIView {
    
    weak var delegate : ProfileFilterViewDelegate?

    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .white
        collection.delegate = self
        collection.dataSource = self
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.register(ProfileFilterCell.self, forCellWithReuseIdentifier: filterIdentifier)
        
        let selectedIndexPath = IndexPath(row: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .left)
        addSubview(collectionView)
        collectionView.addConstraintsToFillView(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension ProfileFilterView : UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ProfileFilterOptions.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: filterIdentifier, for: indexPath) as! ProfileFilterCell
        let option = ProfileFilterOptions(rawValue: indexPath.row)
        cell.option = option
        return cell
    }

}

extension ProfileFilterView : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.filterView(self, didSelect: indexPath)
    }
}

extension ProfileFilterView : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / CGFloat(ProfileFilterOptions.allCases.count) , height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}



