//
//  ViewController.swift
//  Recipe
//
//  Created by Chaekyeong Lee on 2022/11/20.
//

import UIKit

class ViewController: UIViewController {
    
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
        
//        stackView.addArrangedSubview(label)
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        //stackView.addArrangedSubview(loginBtn)
//        //stackView.addArrangedSubview(logoutBtn)
//
//        self.view.addSubview(stackView)
//
//        let safeArea = view.safeAreaLayoutGuide
//
//        label.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16).isActive = true
    }

    @IBAction func loginBtnClicked(_ sender: UIButton) {
        print("loginBtn call")
        kakaoAuthViewModel.handleKakaoLogin()
    }
    
//    @objc func loginBtnClicked() {
//
//    }
    
    @IBAction func logoutBtnClicked(_ sender: UIButton) {
        print("logoutBtn call")
        kakaoAuthViewModel.handleKakaoLogout()
    }
    
//    @objc func logoutBtnClicked() {
//
//    }
}

