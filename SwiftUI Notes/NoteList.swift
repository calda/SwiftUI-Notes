//
//  NoteList.swift
//  SwiftUI Notes
//
//  Created by Cal Stephens on 6/22/19.
//  Copyright © 2019 Cal Stephens. All rights reserved.
//

import SwiftUI
import CoreData


// MARK: - NoteList

struct NoteList: View {
    
    @ObjectBinding var resultsController = FetchedResultsController(
        with: FetchRequest(for: Note.self)
            .sorted(by: \.lastModificationDate))
    
    var body: some View {
        NavigationView {
            List {
                ForEach(resultsController.objects) { note in
                    NavigationButton(
                        destination: NoteList(),
                        label: { NoteCell(note: note) })
                }
            }.navigationBarTitle(Text("SwiftUI Notes"))
             .navigationBarItems(
                trailing: PresentationButton(
                    destination: NavigationView { ComposeNoteView() },
                    label: {
                        Image(systemName: "square.and.pencil")
                    })
                    .padding(.all, 12))
        }
    }
    
    
}


// MARK: - NoteCell

struct NoteCell : View {
    
    @State var note: Note
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    var body: some View {
        return VStack(alignment: .leading) {
            Text(note.title!)
                .font(.headline)
            
            Text(note.body!)
                .font(.subheadline)
                .lineLimit(3)
            
            Text(dateFormatter.string(from: note.lastModificationDate!))
                .font(.footnote)
                .color(.secondary)
        }.padding(8)
    }
}



// MARK: - Preview

#if DEBUG
struct NoteList_Previews : PreviewProvider {
    static var previews: some View {
        let content = NoteList()
        
        content.resultsController.stubbedArray = [
            Note(
                title: "Test Note 1",
                body: "Hello! This is my cool test note."),
            Note(
                title: "Test Note 2",
                body: "I'm enjoying experimenting with SwiftUI and CoreData. It seems like CoreData could use a fresh set of Swift bindings that aren't shackled to @objc.")]
        
        return content
    }
}
#endif
