//
//  FilteredCatViewController.swift
//  Meow
//
//  Created by Marc on 23/11/20.
//

import UIKit
import RealmSwift
import Moya

class FilteredCatViewController: UIViewController, ViewControllerDelegate {
    @IBOutlet var catBasicView: CatBaseView!
    @IBOutlet weak var adoptBtn: UIButton!
    @IBOutlet weak var catBtn: UIButton!
    @IBOutlet weak var ansFld: UITextField!
    @IBOutlet weak var qnLbl: UILabel!
    @IBOutlet weak var categoriesPicker: UIPickerView!
    
    var categoriesDataSource: CategoriesDataSource?
    var ans: Int = 0;
    var currentCategory:Category!
    
    lazy var viewModel:CatViewModel = {
        let viewModel = CatViewModel(dataSource: categoriesDataSource)
        return viewModel
    }()
    
    lazy var filterViewModel:FilterViewModel = {
        let viewModel = FilterViewModel()
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCategoriesView()
        self.viewModel = CatViewModel(dataSource: self.categoriesDataSource)
        self.viewModel.getCategories()
        self.catBasicView.state = .loading
        ansFld.delegate = self
    }
    
    func categoriesPickerView(_ categoriesPickerView: UIPickerView, didSelectRow row: Int)
    {
        guard let dataSource = self.categoriesDataSource else { return }
        self.currentCategory = dataSource.data.value[row]
        catBtn.setTitle(currentCategory.name, for: .normal)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getRamdomQuestion()
    }

    @IBAction func getANewCatAction(_ sender: Any) {
        if let a = Int(ansFld.text ?? "0") {
            if a == ans {
                fetchCatByCategory(categoryID: self.currentCategory.id ?? 1)
            }
        }
        getRamdomQuestion()
    }
    
    @IBAction func adoptCatAction(_ sender: Any) {
        self.viewModel.saveCatToDatabase()
    }

    @IBAction func categoryButtonAction(_ sender: Any) {
        categoriesPicker.isHidden = false
    }
}

extension FilteredCatViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
        {
        ansFld.resignFirstResponder()
            return true;
        }
}

extension FilteredCatViewController {
    func setupCategoriesView() {
        self.categoriesDataSource = CategoriesDataSource(withDelegate: self)
        self.categoriesPicker.dataSource = self.categoriesDataSource
        self.categoriesPicker.delegate = self.categoriesDataSource
        self.categoriesDataSource?.data.addAndNotify(observer: self) { [weak self] _ in
            guard let self = self else { return }
            self.categoriesPicker.reloadComponent(0)
            if let value:[Category] = self.categoriesDataSource?.data.value {
                if value.count != 0 {
                    self.currentCategory = value[0]
                    self.catBtn.setTitle(self.currentCategory.name, for: .normal)
                }
            }
        }
    }
    
    func getRamdomQuestion() {
        var numA: Int = 0
        var numB: Int = 0
        var op: Int = 0
        
        numA = Int.random(in: 1..<10)
        numB = Int.random(in: 1..<10)
        op = Int.random(in: 0..<4)
        
        let (question, answer) = self.filterViewModel.getRamdomQuestion(numA: numA, numB: numB, op: op)
        qnLbl.text = question
        ans = answer
        ansFld.text = "0"
    }
    
    func fetchCatByCategory(categoryID: Int) {
        self.viewModel.fetchCatByCategory(categoryID: categoryID) {  [weak self] outcome in
            guard let self = self else { return }
            switch outcome {
            case .success:
                self.catBasicView.state = .loading
                self.catBasicView.catImgURL = self.viewModel.imgURL
            case .failure:
                self.catBasicView.state = .error
                self.catBasicView.catImgURL = ""
            }
        }
    }
    
}
