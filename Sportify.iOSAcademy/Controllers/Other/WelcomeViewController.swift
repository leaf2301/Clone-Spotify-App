//
//  WelcomeViewController.swift
//  Sportify.iOSAcademy
//
//  Created by Tran Hieu on 25/12/2023.
//

import UIKit

class WelcomeViewController: UIViewController {

    private let signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Sign In with Spotify", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Spotify"
        view.backgroundColor = .systemGreen
        view.addSubview(signInButton)
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        signInButton.frame = .init(x: 20, y: view.height-50-view.safeAreaInsets.bottom, width: view.width-40, height: 50)
    }
    
    @objc func didTapSignIn() {
        print("Why I cant sign in?")
        let vc = AuthViewController()
        vc.completionHandler = { [weak self] success in
            DispatchQueue.main.async {
                self?.handleSignIn(success: success)
            }
             
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
        
    }

    private func handleSignIn(success: Bool) {
        guard success else {
            print(success)
            let alert = UIAlertController(title: "Oops", message: "Something went wrong", preferredStyle: .alert)
            alert.addAction(.init(title: "Dismiss", style: .cancel))
            present(alert, animated: true)
            return
        }
        
        let mainAppTabbarVC = TabbarViewController()
        mainAppTabbarVC.modalPresentationStyle = .fullScreen
        present(mainAppTabbarVC, animated: true)
    }
}
