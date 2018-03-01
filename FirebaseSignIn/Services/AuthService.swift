//
//  AuthService.swift
//  FirebaseSignIn
//
//  Created by Robert Wais on 2/28/18.
//  Copyright © 2018 Robert Wais. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
    static let instance = AuthService()
    
    func registerUser(email: String, password:String, complete: @escaping (_ status: Bool, _ error: Error?) -> ()){
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            
            guard let user = user else {
                complete(false,error)
                return
            }
            
            
            let userData = ["provider": user.providerID, "email": user.email]
            DataService.instance.createDBUser(uniqueID: user.uid, userData: userData)
            complete(true,nil)
        }
    }
    
    func loginUser(email: String, password:String, complete: @escaping (_ status: Bool, _ error: Error?) -> ()){
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if error != nil {
                complete(false,error)
                return
            }
            
            complete(true,nil)
            
        }
    }
}
