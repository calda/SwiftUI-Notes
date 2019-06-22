//
//  NoteExtensions.swift
//  SwiftUI Notes
//
//  Created by Cal Stephens on 6/22/19.
//  Copyright © 2019 Cal Stephens. All rights reserved.
//

import CoreData
import SwiftUI

extension Note : Identifiable { }

extension Note {
    
    convenience init(
        title: String,
        body: String,
        dateCreated: Date = NSDate.now)
    {
        self.init(context: AppDelegate.shared.persistentContainer.viewContext)
        self.title = title
        self.body = body
        self.lastModificationDate = dateCreated
    }
    
}
