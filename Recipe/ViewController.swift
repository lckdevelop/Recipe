//
//  ViewController.swift
//  Recipe
//
//  Created by Chaekyeong Lee on 2022/11/20.
//

import UIKit
import Combine

class ViewController: UIViewController {
    var subscriptions = Set<AnyCancellable>()
    
    @IBOutlet weak var kakaoLoginStauts: UILabel!
    
    lazy var loginBtn : UIButton = {
        let loginBtn = UIButton()
        loginBtn.setTitle("카카오로 로그인", for: .normal)
        loginBtn.addTarget(self, action: #selector(loginBtnClicked), for: .touchUpInside)
        loginBtn.translatesAutoresizingMaskIntoConstraints = false

        return loginBtn
    }()
    
    lazy var logoutBtn : UIButton = {
        let logoutBtn = UIButton()
        logoutBtn.setTitle("카카오 로그아웃", for: .normal)
        logoutBtn.addTarget(self, action: #selector(logoutBtnClicked), for: .touchUpInside)
        logoutBtn.translatesAutoresizingMaskIntoConstraints = false

        return logoutBtn
    }()
    
    lazy var stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 0
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        
        return stackView
    }()
    
    lazy var kakaoAuthViewModel: KakaoAuthViewModel = {
        KakaoAuthViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBinding()
    }

    @IBAction func loginBtnClicked(_ sender: UIButton) {
        print("loginBtn call")
        kakaoAuthViewModel.KakaoLogin()
    }
    
    @IBAction func logoutBtnClicked(_ sender: UIButton) {
        print("logoutBtn call")
        kakaoAuthViewModel.KakaoLogout()
    }
    

}

extension ViewController {
    fileprivate func setBinding() {
//        self.kakaoAuthViewModel.$isLoggedIn.sink { [weak self] isLoggedIn in
//            guard let self = self else { return }
//
//            self.kakaoLoginStauts.text = isLoggedIn ? "로그인 상태" : "로그아웃 상태"
//        }
//        .store(in: &subscriptions)
        
        self.kakaoAuthViewModel.loginStatusInfo
            .receive(on: DispatchQueue.main)
            .assign(to: \.text, on: self.kakaoLoginStauts)
            .store(in: &subscriptions)
    }
}

