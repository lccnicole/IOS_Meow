//
//  AdoptedCatDataSource.swift
//  Meow
//
//  Created by Leong, Choi Chee on 8/2/21.
//

import Foundation
import UIKit

class catDataSource<T> : NSObject {
    var data: DynamicValue<[T]> = DynamicValue([])
}

class AdoptedCatDataSource : GenericDataSource<CatElement>, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(data.value.count)
        return data.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! AdoptedCatCollectionViewCell
        
        let currentCat = data.value[indexPath.row]
        cell.catImg.kf.setImage(with: URL(string: currentCat.url)){ result in
                // `result` is either a `.success(RetrieveImageResult)` or a `.failure(KingfisherError)`
                switch result {
                case .success(let value):
                    // The image was set to image view:
                    print(value.image)
                    //cat.img = value.image.pngData() ?? Data()

                    // From where the image was retrieved:
                    // - .none - Just downloaded.
                    // - .memory - Got from memory cache.
                    // - .disk - Got from disk cache.
                    print(value.cacheType)

                    // The source object which contains information like `url`.
                    print(value.source)

                case .failure(let error):
                    print(error) // The error happens
                }
            }

    //        if currentCat.img?.count == 0 {
    //            cell.getCatImg(with: currentCat.id)
    //        } else {
    //            cell.catImg.kf. image = UIImage(data: currentCat.img ?? Data())
    //        }
            
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            return CGSize(width: collectionView.bounds.size.width / 3.0, height: collectionView.bounds.size.width / 3.0)
        }
}
