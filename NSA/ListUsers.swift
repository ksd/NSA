//
//  ListUsers.swift
//  NSA
//
//  Created by ksd on 30/03/2022.
//

import SwiftUI

struct ListUsers: View {
    
    @EnvironmentObject var stateController: StateController
    
    @State private var isShowingDeleteConfirmationDialog = false
    @State private var deletionOffsets : IndexSet  = []
    
    var body: some View {
        NavigationView {
            List {
                ForEach (displayedUsers) {user in
                    NavigationLink(){
                        Text("detalje")
                    } label:
                    {
                        Text("\(user.first) \(user.last)")
                    }
                }
                .onDelete { offsets in
                    deletionOffsets = offsets
                    isShowingDeleteConfirmationDialog = true
                }
                .confirmationDialog("Vi du slette \(getSelectedUserName())?",
                                    isPresented: $isShowingDeleteConfirmationDialog,
                                    titleVisibility: .visible) {
                    Button("Slet", role: .destructive) {
                        if let index = deletionOffsets.first {
                            stateController.deleteUser(displayedUsers[index])
                        }
                    }
                }
            }
            .navigationTitle("Users")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        AddUser()
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                    
                }
            }
        }
    }
}

private extension ListUsers {
    
    var displayedUsers : [User] {
        stateController.users.sorted {
            $0.last < $1.last
        }
    }
    
    func getSelectedUserName() -> String {
        if let index = deletionOffsets.first {
            let user = displayedUsers[index]
            return "\(user.first) \(user.last)"
        } else {
            return ""
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ListUsers().environmentObject(StateController())
    }
}
