//
//  firebase.swift
//  NSA
//
//  Created by ksd on 30/03/2022.
//

import Foundation
import Firebase

class FirebaseService {
    
    private let dbRef = Firestore.firestore()
    private var ref: DocumentReference?
    private var listner: ListenerRegistration?
    
    deinit {
        listner?.remove()
    }
    
    /// dummy add function only to be used for demo
    func addDummy(){
        ref = dbRef.collection("users").addDocument(data: [
            "first": "Ada",
            "last": "Lovelace",
            "born": 1815
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(self.ref!.documentID)")
            }
        }
    }
    
    func add(user: User){
        let ref = dbRef.collection("users")
        do {
            _ = try ref.addDocument(from: user)
        }
        catch {
            print(error)
        }
    }
    
    func delete(documentID: String){
        dbRef.collection("users").document(documentID).delete()
    }
    
    func listen(completionHandler: @escaping ([QueryDocumentSnapshot])->Void){
        listner = dbRef.collection("users").addSnapshotListener { [completionHandler] querySnapshot, error in
            guard let querySnapshot = querySnapshot else {
                print("Error: fetching data: \(String(describing: error))")
                return
            }
            completionHandler(querySnapshot.documents)
        }
    }
    
    
}
