//
//  AuthService.swift
//  FirebaseSignIn
//
//  Created by Robert Wais on 2/28/18.
//  Copyright © 2018 Robert Wais. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage


class AuthService {
    static let instance = AuthService()
    var image: UIImage!
    
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
    
    func loginUser(email: String, password:String, complete: @escaping (_ status: Bool, _ error: Error?, _ image: UIImage?) -> ()){
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if error != nil {
                complete(false,error,nil)
                return
            }else{
                let storage = Storage.storage()
                let pathReference = storage.reference(withPath: "Images/CompletedTask.png")
                pathReference.getData(maxSize: 1024*1024, completion: { (data, error) in
                    if let error = error{
                        print("Error: \(error)")
                    }else{
                        let image = UIImage(data: data!)
                        complete(true,nil,image)
                    }
                })
                
                
                
                //Check role
                /*
                print("user id: \((user?.uid)!)")
                DB_BASE.child("users").child((user?.uid)!).child("role").observe(DataEventType.value){ (data) in
                var val = data.value as? String
                    print("Val: \(val)")
                }
                 */
                
                
            }
            complete(true,nil,nil)
            
        }
    }
}
