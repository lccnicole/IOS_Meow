//
//  AdoptedCatsViewController.swift
//  Meow
//
//  Created by Marc on 20/11/20.
//

import UIKit
import RealmSwift
import Kingfisher

class AdoptedCatsViewController: UIViewController {
    
    @IBOutlet weak var catCollectionView: UICollectionView!
    var adoptedCats = try! Realm().objects(CatElement.self)
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    private let itemsPerRow: CGFloat = 3

    override func viewDidLoad() {
        super.viewDidLoad()
        adoptedCats = try! Realm().objects(CatElement.self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        catCollectionView.reloadData()
    }
}

extension AdoptedCatsViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(in collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath
      ) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
      }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int
      ) -> UIEdgeInsets {
        return sectionInsets
      }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int
      ) -> CGFloat {
        return sectionInsets.left
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
        
extension AdoptedCatsViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return adoptedCats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cat = adoptedCats[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! AdoptedCatCollectionViewCell
        cell.backgroundColor = .white
        cell.catImg.kf.setImage(with: URL(string: cat.url)){ result in
            // `result` is either a `.success(RetrieveImageResult)` or a `.failure(KingfisherError)`
            switch result {
            case .success(let value):
                // From where the image was retrieved:
                // - .none - Just downloaded.
                // - .memory - Got from memory cache.
                // - .disk - Got from disk cache. Those saved image for first lauch it get from disk
                print(value)
            case .failure(let error):
                print(error) // The error happens
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
}

        
        
    
    
