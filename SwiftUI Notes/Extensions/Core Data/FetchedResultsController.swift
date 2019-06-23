//
//  FetchRequestBuilder.swift
//  SwiftUI Notes
//
//  Created by Cal Stephens on 6/22/19.
//  Copyright © 2019 Cal Stephens. All rights reserved.
//

import CoreData
import Combine
import SwiftUI

class FetchedResultsController<ResultType>
    : BindableObject
    where ResultType : NSFetchRequestResult
{
    
    let nsFetchedResultsController: NSFetchedResultsController<ResultType>!
    let fetchedResultsControllerDelegateAdaptor = FetchedResultsControllerDelegateAdaptor()
    let didChange = PassthroughSubject<Void, Never>()
    var stubbedArray: [ResultType]? = nil
    
    init(
        with fetchRequest: FetchRequest<ResultType>,
        in managedObjectContext: NSManagedObjectContext = AppDelegate.shared.persistentContainer.viewContext)
    {
        stubbedArray = nil
        nsFetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest.nsFetchRequest,
            managedObjectContext: managedObjectContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        
        nsFetchedResultsController.delegate = fetchedResultsControllerDelegateAdaptor
        
        fetchedResultsControllerDelegateAdaptor.onContentChange = {
            self.didChange.send()
        }
        
        try! nsFetchedResultsController.performFetch()
    }
    
    var objects: [ResultType] {
        return stubbedArray ?? nsFetchedResultsController.fetchedObjects ?? []
    }
    
}



// MARK: FetchedResultsControllerDelegateAdaptor

/// We have to use a little Adaptor class because classes that conform
/// to `NSFetchedResultsControllerDelegate` must subclass `NSObject`.
/// `FetchedResultsController` can't subclass `NSObject` and also be
/// a proper `BindableObject` for SwiftUI.
class FetchedResultsControllerDelegateAdaptor: NSObject, NSFetchedResultsControllerDelegate {
    
    var onContentChange: (() -> Void)?
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        onContentChange?()
    }
    
}
