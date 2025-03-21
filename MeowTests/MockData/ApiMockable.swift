//
//  ApiMockable.swift
//  Meow
//
//  Created by Leong, Choi Chee on 5/2/21.
//

import Foundation

/// Helper for mocking from local json files
class ApiMockUtils {

    /// Loding json data from local file for a given file name
    /// - Parameter name: _String_ file name which should be used for loading data
    static func loadJsonDataFromFile(withName name: String) -> Data? {
        let sdkBundle = Bundle(for: ApiMockUtils.self)
        guard let fileUrl = sdkBundle.url(forResource: name, withExtension: "json") else {
            debugPrint("Could not load json file at path \(name)")
            return nil
        }

        do {
            let data = try Data(contentsOf: fileUrl, options: [])
            return data
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
}
