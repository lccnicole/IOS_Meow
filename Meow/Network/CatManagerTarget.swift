//
//  CatManagerTarget.swift
//  Meow
//
//  Created by Leong, Choi Chee on 4/2/21.
//

import Foundation
import Moya

public enum CatManagerTarget {
    case fetchCat
    case getCategories
    case fetchCatByCategory(Int)
}

extension CatManagerTarget: TargetType {
    public var headers: [String : String]? {
        switch self {
        case .fetchCat:
            return ["Content-Type": "application/json"]
        case .getCategories:
            return ["Content-Type": "application/json", "x-api-key": "DEMO-API-KEY"]
        default:
            return ["Content-Type": "application/json"]
        }
        
    }
    
    public var baseURL: URL {
        switch self {
        case .fetchCatByCategory(let categoryID):
            return URL(string: "https://api.thecatapi.com/v1?category_ids=\(categoryID)")!
        default:
            return URL(string: "https://api.thecatapi.com/v1")!
        }
    }

    public var path: String {
        switch self {
        case .fetchCat:
            return "/images/search"
        case .getCategories:
            return "/categories"
        case .fetchCatByCategory:
            return "/images/search"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .fetchCat,
        .getCategories,
        .fetchCatByCategory: return .get
        }
    }

    public var sampleData: Data {
        return Data()
    }

    public var task: Task {
        switch self {
        case .fetchCat:
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        default:
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }

    public var parameters: [String: Any] {
        switch self {
        case .fetchCat:
            return ["":""]
        default:
            return ["":""]
        }
    }
}

