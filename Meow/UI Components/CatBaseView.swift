//
//  CatBaseView.swift
//  Meow
//
//  Created by Leong, Choi Chee on 7/2/21.
//

import UIKit

class CatBaseView: UIView {
    
    @IBOutlet weak var catImg: UIImageView!
    @IBOutlet weak var lblMessage: UILabel!
    
    var catImgURL: String? {
        didSet {
            guard let imgURL = catImgURL else {
                catImg.isHidden = true
                return
            }
            updateImageView(with: imgURL)
        }
    }
    
    private func updateImageView(with imageURL: String) {
        let url = URL(string: imageURL)
        catImg.kf.cancelDownloadTask()
        catImg.kf.setImage(with: url,  options: [.transition(.fade(0.3))]){ result in
            switch result {
            case .success(_):
                self.state = .ready
            case .failure(_):
                self.state = .error
            }
        }
    }
    
    var state: CatViewModel.State = .loading {
        didSet {
              switch state {
              case .ready:
                catImg.isHidden = false
                lblMessage.isHidden = true
              case .loading:
                catImg.isHidden = true
                lblMessage.text = "Getting cat ..."
              case .error:
                catImg.isHidden = true
                lblMessage.text = """
                                    Something went wrong!
                                    Try again later.
                                  """
              }
        }
    }
}
