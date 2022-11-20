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
    var subscription = Set<AnyHashable>()
    
    func handleKakaoLogin() {
        // 카카오톡 설치 여부 확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
            // 카카오 앱으로 로그인
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")

                    //do something
                    _ = oauthToken
                }
            }
        } else { // 카카오톡 앱이 없을 시
            // 카카오 계정으로 로그인
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoAccount() success.")

                    //do something
                    _ = oauthToken
                }
            }
        }
    } // 로그인
    
    func handleKakaoLogout() {
        UserApi.shared.logout {(error) in
            if let error = error {
                print(error)
            }
            else {
                print("logout() success.")
            }
        }
    } // 로그아웃
}
