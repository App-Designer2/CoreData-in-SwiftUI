//
//  ContentView.swift
//  CoreData1
//
//  Created by App-Designer2 . on 31.08.19.
//  Copyright © 2019 App-Designer2 . All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: Users.entity(),
                  sortDescriptors: [
                    NSSortDescriptor(keyPath: \Users.name, ascending: true),
                    NSSortDescriptor(keyPath: \Users.date, ascending: true)
         ]
    ) var User: FetchedResults<Users>
    
    @State private var addNew: String = ""
    
    var body: some View {
        NavigationView {
            List {
                HStack {
                TextField("Add new..", text: self.$addNew)
                
                Button(action: {
                    let users = Users(context: self.managedObjectContext)
                    users.name = self.addNew
                    users.date = Date()
                    
                    do {
                        //This is for save in our store what we input.
                        try self.managedObjectContext.save()
                    } catch {
                        if self.managedObjectContext.hasChanges {
                            fatalError("The info did not save :(")
                        }
                    }
                    self.addNew = ""
                }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.green)
                }
                }
                
                Section(header: Text("New user")) {
                    ForEach(User, id: \.self) { user in
                        HStack {
                            Text("App-Designer2: ").font(.headline)
                            Text("@\(user.name ?? "\(String(describing: user.date) )")")
                            
                        }
                    }.onDelete(perform: deleteItem)
                }
            }.navigationBarTitle(Text("Users"))
            .navigationBarItems(trailing: EditButton())
        }
    }
    // we implemented this code here to delete items from our core data
    func deleteItem(at offsets: IndexSet) {
        for index in offsets {
            let usera = User[index]
            managedObjectContext.delete(usera)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
