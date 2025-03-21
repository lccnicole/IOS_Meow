//
//  CatViewModel.swift
//  Meow
//
//  Created by Leong, Choi Chee on 7/2/21.
//

import Foundation
import Moya
import RealmSwift


class CatViewModel {
    weak var dataSource : GenericDataSource<Category>?
    
    private var currentCat: CatElement?
    private var provider = MoyaProvider<CatManagerTarget>()
    var categories = [Category]()
    
    init() {
        print("REALM DB: \(Realm.Configuration.defaultConfiguration.fileURL!)")
    }
    
    init(dataSource : GenericDataSource<Category>?, stubClosure: @escaping MoyaProvider<CatManagerTarget>.StubClosure = MoyaProvider.neverStub, endpointClosure: @escaping MoyaProvider<CatManagerTarget>.EndpointClosure = MoyaProvider.defaultEndpointMapping) {
        self.dataSource = dataSource
        self.provider = MoyaProvider<CatManagerTarget>(endpointClosure: endpointClosure, stubClosure: stubClosure)
    }
}

extension CatViewModel {
    func fetchCat(then handler: @escaping (Outcome) -> Void) {
        provider.request(.fetchCat) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
            do {
                print(response)
                let cats = try response.map([CatElement].self, failsOnEmptyData: false)
                let cat = cats[0]
                self.currentCat = cat
                handler(.success)
            } catch {
                handler(.failure)
            }
          case .failure:
            handler(.failure)
          }
        }
    }
    
    func fetchCatByCategory(categoryID:Int, then handler: @escaping (Outcome) -> Void) {
       
        provider.request(.fetchCatByCategory(categoryID)) { [weak self] result in
            guard let self = self else { return }
            switch result {
                case .success(let response):
                do {
                    print(try response.mapJSON())
                    let cats = try response.map([CatElement].self, failsOnEmptyData: false)
                    self.currentCat = cats[0]
                    handler(.success)
                } catch {
                    handler(.failure)
                }
                case .failure:
                    handler(.failure)
          }
        }
    }
    
    func getCategories() {
        provider.request(.getCategories) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
            do {
                let categories = try response.map([Category].self, failsOnEmptyData: false)
                self.categories = categories
                self.dataSource?.data.value = categories
                
            } catch {
                self.dataSource?.data.value = self.categories
            }
          case .failure:
            self.dataSource?.data.value = self.categories
          }
        }
    }
}

extension CatViewModel {
    func saveCatToDatabase() {
        guard currentCat != nil else {
            print("nope")
            return
        }
        let realm = try! Realm()
        
        try! realm.write {
            if let cat = currentCat {
                cat.adoptedAt = Date()
                realm.add(cat, update: .modified)
                print("saved!")
            }
        }
    }
}

extension CatViewModel {
    var imgURL: String {
        return currentCat?.url ?? ""
    }
    
    var category: Category? {
        return currentCat?.categories?[0]
    }
}

extension CatViewModel {
  enum State {
    case loading
    case ready
    case error
  }
}

extension CatViewModel {
  enum Outcome {
    case success
    case failure
  }
}

typealias CompletionHandler = (() -> Void)
