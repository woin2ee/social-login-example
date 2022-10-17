//
//  MainViewController.swift
//  SocialLoginExample
//
//  Created by Jaewon on 2022/10/13.
//

import UIKit
import KakaoSDKUser
import KakaoSDKAuth

final class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapKakaoLogin(_ sender: UIButton) {
        print("KakaoLogin")
        
        if AuthApi.hasToken() {
            UserApi.shared.accessTokenInfo { accessTokenInfo, error in
                if let _ = error {
                    self.loginWithKakao()
                } else {
                    print("AccessTokenInfo: \(String(describing: accessTokenInfo))")
                }
            }
        } else {
            loginWithKakao()
        }
    }
    
    private func loginWithKakao() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                } else {
                    print("Access Token 발급 성공")
                    _ = oauthToken
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                } else {
                    print("Access Token 발급 성공")
                    _ = oauthToken
                }
            }
        }
    }
}
