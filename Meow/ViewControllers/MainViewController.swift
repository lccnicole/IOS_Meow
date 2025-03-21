//
//  MainViewController.swift
//  Meow
//
//  Created by Marc on 20/11/20.
//

import UIKit



class MainViewController: UIViewController {

    @IBOutlet var catBasicView: CatBaseView!
    @IBOutlet weak var adoptBtn: UIButton!
  
    private var viewModel: CatViewModel?
    var currentCat: CatElement?
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = CatViewModel()
        self.catBasicView.state = .loading
        fetchCat()
    }
    
    @IBAction func getANewCatAction(_ sender: Any) {
        fetchCat()
    }
    
    func fetchCat() {
        self.viewModel?.fetchCat() {  [weak self] outcome in
            guard let self = self else { return }
            switch outcome {
            case .success:
                self.catBasicView.state = .loading
                self.catBasicView.catImgURL = self.viewModel?.imgURL
            case .failure:
                self.catBasicView.state = .error
                self.catBasicView.catImgURL = ""
            }
        }
    }

    @IBAction func adoptCatAction(_ sender: Any) {
        self.viewModel?.saveCatToDatabase()
    }
}


