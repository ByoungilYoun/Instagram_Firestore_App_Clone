//
//  LoginController.swift
//  Instagram_Firestore_App_Clone
//
//  Created by 윤병일 on 2021/03/28.
//

import UIKit

class LoginController : UIViewController {
  
  //MARK: - Properties
  
  // Instagram 아이콘 이미지
  private let iconImageView : UIImageView = {
    let iv = UIImageView(image: #imageLiteral(resourceName: "Instagram_logo_white"))
    iv.contentMode = .scaleAspectFill
    return iv
  }()
  
  // 이메일 텍스트 필드
  private let emailTextField : UITextField = {
    let tf = UITextField()
    tf.borderStyle = .none
    tf.textColor = .white
    tf.keyboardAppearance = .dark
    tf.keyboardType = .emailAddress
    tf.backgroundColor = UIColor(white: 1, alpha: 0.1)
    tf.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [.foregroundColor : UIColor(white: 1, alpha: 0.7)])
    return tf
  }()
  
  // 패스워드 텍스트 필드
  private let passwordTextField : UITextField = {
    let tf = UITextField()
    tf.borderStyle = .none
    tf.textColor = .white
    tf.keyboardAppearance = .dark
    tf.keyboardType = .emailAddress
    tf.backgroundColor = UIColor(white: 1, alpha: 0.1)
    tf.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [.foregroundColor : UIColor(white: 1, alpha: 0.7)])
    tf.isSecureTextEntry = true
    return tf
  }()
  
  // 로그인 버튼
  private let loginButton : UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Log In", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
    button.layer.cornerRadius = 5
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    return button
  }()
  
  private let forgotPasswordButton : UIButton = {
    let button = UIButton(type: .system)
    let atts : [NSAttributedString.Key : Any] = [.foregroundColor : UIColor(white: 1, alpha: 0.7), .font : UIFont.systemFont(ofSize: 16)]
    let attributedTitle = NSMutableAttributedString(string: "Forgot your password?  ", attributes: atts)
    let boldAtts : [NSAttributedString.Key : Any] = [.foregroundColor : UIColor(white: 1, alpha: 0.7), .font : UIFont.boldSystemFont(ofSize: 16)]
    attributedTitle.append(NSAttributedString(string: "Get help signing in", attributes: boldAtts))
    button.setAttributedTitle(attributedTitle, for: .normal)
    return button
  }()
  
  
  private let dontHaveAccountButton : UIButton = {
    let button = UIButton(type: .system)
    let atts : [NSAttributedString.Key : Any] = [.foregroundColor : UIColor(white: 1, alpha: 0.7), .font : UIFont.systemFont(ofSize: 16)]
    let attributedTitle = NSMutableAttributedString(string: "Don't have an account? ", attributes: atts)
    let boldAtts : [NSAttributedString.Key : Any] = [.foregroundColor : UIColor(white: 1, alpha: 0.7), .font : UIFont.boldSystemFont(ofSize: 16)]
    attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: boldAtts))
    button.setAttributedTitle(attributedTitle, for: .normal)
    return button
  }()
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setNavi()
    configureUI()
  }
  
  
  //MARK: - Helpers
  private func setNavi() {
    
    navigationController?.navigationBar.isHidden = true // 네비게이션 바 없애기
    navigationController?.navigationBar.barStyle = .black // 네비게이션 시간 보여지는 곳에 라이트 모드이거나 다크 모두 둘다 하얀색으로 나온다.
  }
  
  private func configureUI() {
    view.backgroundColor = .white
    
    let gradient = CAGradientLayer()
    gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemBlue.cgColor]
    gradient.locations = [0, 1]
    view.layer.addSublayer(gradient)
    gradient.frame = view.frame
    
    
    view.addSubview(iconImageView)
    iconImageView.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(32)
      $0.height.equalTo(80)
      $0.width.equalTo(120)
    }

    // 이메일, 패스워드 텍스트 필드, 로그인버튼 height 만 주기
    [emailTextField, passwordTextField, loginButton].forEach {
      $0.snp.makeConstraints {
        $0.height.equalTo(50)
      }
    }
    
    //스택뷰에 이메일, 패스워드 텍스트 필드 넣어서 사용
    let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton, forgotPasswordButton])
    stack.axis = .vertical
    stack.spacing = 20
    view.addSubview(stack)
    
    stack.snp.makeConstraints {
      $0.top.equalTo(iconImageView.snp.bottom).offset(32)
      $0.leading.equalToSuperview().offset(32)
      $0.trailing.equalToSuperview().offset(-32)
    }
    
    view.addSubview(dontHaveAccountButton)
    dontHaveAccountButton.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
    }
  }
}
