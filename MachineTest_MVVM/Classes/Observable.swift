//
//  Observable.swift
//  MachineTest_MVVM
//
//  Created by 7KINGSCODE on 6/22/23.
//

import Foundation

class Observable<T> {
    
    var listener: ((T?) -> Void)?
    
    var value: T? {
        didSet{
            DispatchQueue.main.async {
                self.listener?(self.value)
            }
        }
    }
    
    init(_ value: T?) {
        self.value = value
    }
    
    func bind(_ listener: @escaping ((T?) -> Void)) {
        
        listener(value)
        self.listener = listener
    }
}
