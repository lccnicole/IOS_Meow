//
//  CategoryDataSource.swift
//  Meow
//
//  Created by Leong, Choi Chee on 8/2/21.
//


import Foundation
import UIKit

///I wanted to separate the ViewModel to the data layer. For that reason, I create a generic dataSource that we can reuse regardless the data we would like to update.
class GenericDataSource<T> : NSObject {
    var data: DynamicValue<[T]> = DynamicValue([])
}

protocol ViewControllerDelegate: class {
    func categoriesPickerView(_ categoriesPickerView: UIPickerView, didSelectRow row: Int)
}

class CategoriesDataSource : GenericDataSource<Category>, UIPickerViewDelegate, UIPickerViewDataSource {
    
    weak var delegate: ViewControllerDelegate?
    
    init(withDelegate delegate: ViewControllerDelegate) {
            self.delegate = delegate
        }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.value.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let catgory = data.value[row]
        return catgory.name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.delegate?.categoriesPickerView(pickerView, didSelectRow: row)
        pickerView.isHidden = true
    }
}


