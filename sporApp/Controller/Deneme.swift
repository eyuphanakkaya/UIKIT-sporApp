//
//  Deneme.swift
//  sporApp
//
//  Created by Eyüphan Akkaya on 1.07.2023.
//

import Foundation
import AuthenticationServices

class SignInWithAppleManager: NSObject {
    static let shared = SignInWithAppleManager()
    
    func signInWithAppleButtonTapped() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

extension SignInWithAppleManager: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            // Kullanıcı Apple ID kimlik bilgilerini aldık, Firebase'e giriş yapabilirsiniz.
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            // Firebase ile giriş işlemlerini burada gerçekleştirin
        default:
            break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Hata oluştu
        print("Hata: \(error.localizedDescription)")
    }
}

extension SignInWithAppleManager: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        // Apple giriş yapma ekranının gösterileceği yer
        return UIApplication.shared.windows.first!
    }
}
