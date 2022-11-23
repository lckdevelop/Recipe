//
//  KakaoAuth.swift
//  Recipe
//
//  Created by Chaekyeong Lee on 2022/11/20.
//

import Foundation
import Combine
import KakaoSDKAuth
import KakaoSDKUser

class KakaoAuthViewModel: ObservableObject {
    var subscription = Set<AnyCancellable>()
    
    @Published var isLoggedIn : Bool = false
    
    lazy var loginStatusInfo : AnyPublisher<String?, Never> = $isLoggedIn.compactMap{ $0 ? "로그인 상태" : "로그아웃 상태" }.eraseToAnyPublisher()
    init() {
        print("KakaoAuthViewModel - init() called")
    }
    
    func KakaoLogin() {
        Task{
            // 카카오톡 설치 여부 확인
            if (UserApi.isKakaoTalkLoginAvailable()) {
                // 카카오 앱으로 로그인
                isLoggedIn = await kakaoLoginWithApp()
                
            } else { // 카카오톡 앱이 없을 시
                // 카카오 계정으로 로그인
                isLoggedIn = await kakaoLoginWithAccount()
            }
        }
    } // 로그인
    
    func KakaoLogout() {
        Task {
            if await handleKakaoLogout() {
                self.isLoggedIn = false
            }
        }
    } // 로그아웃
    
    func kakaoLoginWithApp() async -> Bool {
        await withCheckedContinuation{ continuation in
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                }
                else {
                    print("loginWithKakaoTalk() success.")

                    //do something
                    _ = oauthToken
                    continuation.resume(returning: true)
                }
            }
            
        }
    }
    
    func kakaoLoginWithAccount() async -> Bool {
        await withCheckedContinuation{ continuation in
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                }
                else {
                    print("loginWithKakaoAccount() success.")
                    
                    //do something
                    _ = oauthToken
                    continuation.resume(returning: true)
                }
            }
        }
    }
        
    func handleKakaoLogout() async -> Bool {
        await withCheckedContinuation{ continuation in
            UserApi.shared.logout {(error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                }
                else {
                    print("logout() success.")
                    continuation.resume(returning: true)
                }
            }
            
        }
    }
}
