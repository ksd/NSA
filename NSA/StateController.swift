//
//  StateController.swift
//  NSA
//
//  Created by ksd on 30/03/2022.
//

import Foundation

class StateController: ObservableObject {
    
    private let db = FirebaseService()
    
    @Published var users = [User]()
    
    init(){
        db.listen(){ docs in
            var user: User?
            self.users.removeAll()
            self.users = docs.compactMap { queryDocumentSnapshot in
                do {
                    user = try queryDocumentSnapshot.data(as: User.self)
                }
                catch {
                    print("Så for pokker")
                }
                return user
            }
        }
    }
    
    func addUser(first: String, last: String, born: Int){
        db.add(user: User(first: first, last: last, born: born))
    }
    
    
    func deleteUser(_ originalUser: User) {
        
        // find index i users for originalUser ellers giv op (return)
        let indexOfOriginal = users.firstIndex { $0.id == originalUser.id }
        guard let indexOfOriginal = indexOfOriginal else {
            return
        }
        
        // unwrap id og slet via Firebase
        if let documentID = users[indexOfOriginal].id {
            users.remove(at: indexOfOriginal)
            db.delete(documentID: documentID)
        }
    }
    
}
