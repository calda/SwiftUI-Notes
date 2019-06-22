//
//  FetchRequest.swift
//  SwiftUI Notes
//
//  Created by Cal Stephens on 6/22/19.
//  Copyright © 2019 Cal Stephens. All rights reserved.
//

import CoreData
import SwiftUI
import Combine


// MARK: - FetchRequest

class FetchRequest<ResultType> where ResultType : NSFetchRequestResult {
    
    let nsFetchRequest: NSFetchRequest<ResultType>
    
    
    // MARK: Initialization
    
    init(for resultType: ResultType.Type) {
        self.nsFetchRequest = NSFetchRequest<ResultType>(entityName: String(describing: ResultType.self))
    }
    
    func sorted<Value>(
        by keyPath: ReferenceWritableKeyPath<ResultType, Value>,
        ascending: Bool = true) -> Self
    {
        nsFetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: keyPath, ascending: ascending)]
        return self
    }
    
}



