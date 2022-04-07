//
//  AddUser.swift
//  NSA
//
//  Created by ksd on 06/04/2022.
//

import SwiftUI

struct AddUser: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var stateController: StateController
    
    @State private var first = ""
    @State private var last = ""
    @State private var birthDate = Date()
    
    var body: some View {
        Form {
            Section(header: Text("Profile")) {
                TextField("Firstname", text: $first)
                    .keyboardType(.alphabet)
                TextField("Lastname", text: $last)
                    .keyboardType(.alphabet)
                DatePicker(
                    "Birthday",
                    selection: $birthDate,
                    displayedComponents: [.date]
                )
                //.datePickerStyle(GraphicalDatePickerStyle())
            }
        }
        .navigationBarTitle("Add User")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    // Vi skal bare bruge årstallet til vores demo, derfor laver jeg en Calendar
                    let calendar = Calendar.current
                    let components = calendar.dateComponents([.year], from: birthDate)
                    let year = components.year
                    
                    stateController.addUser(first: first, last: last, born: year ?? 0)
                    dismiss()
                } label: {
                    Text("OK")
                }
            }
        }
    }
}

struct AddUser_Previews: PreviewProvider {
    static var previews: some View {
        AddUser().environmentObject(StateController())
    }
}
