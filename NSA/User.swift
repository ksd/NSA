//
//  User.swift
//  NSA
//
//  Created by ksd on 30/03/2022.
//

import Foundation
import FirebaseFirestoreSwift


struct User: Codable, Identifiable {
    @DocumentID var id: String?
    var first: String
    var last: String
    var born: Int
}
