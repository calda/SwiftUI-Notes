//
//  ComposeNoteView.swift
//  SwiftUI Notes
//
//  Created by Cal Stephens on 6/22/19.
//  Copyright © 2019 Cal Stephens. All rights reserved.
//

import SwiftUI


// MARK: - ComposeNoteView

struct ComposeNoteView : View {
    
    @Environment(\.isPresented) var isPresented: Binding<Bool>?
    
    @State private var title = "New Note"
    @State private var noteBody = ""
    
    var body: some View {
        List {
            VStack(alignment: .leading) {
                Text("Title")
                    .font(.headline)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                
                TextField(Binding<String>(
                    getValue: { self.title },
                    setValue: { self.title = $0 }))
                    .font(.body)
            }
            
            VStack(alignment: .leading) {
                Text("Your Note")
                    .font(.headline)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                
                TextField(Binding<String>(
                    getValue: { self.noteBody },
                    setValue: { self.noteBody = $0 }))
                    .frame(minHeight: 200)
            }
            
        }.navigationBarTitle(Text("Compose Note"))
         .navigationBarItems(trailing:
            Button(
                action: doneButtonPressed,
                label: { Text("Done")}))
    
    }
    
    func doneButtonPressed() {
        let note = Note(title: title, body: noteBody)
        
        isPresented?.value = false
    }
    
}


#if DEBUG
struct ComposeNoteView_Previews : PreviewProvider {
    static var previews: some View {
        NavigationView {
            ComposeNoteView()
        }
    }
}
#endif
