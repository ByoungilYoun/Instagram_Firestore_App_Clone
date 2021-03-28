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
  private let emailTextField : CustomTextField = {
    let tf = CustomTextField(placeholder: "Email")
    tf.keyboardType = .emailAddress
    return tf
  }()
  
  // 패스워드 텍스트 필드
  private let passwordTextField : CustomTextField = {
    let tf = CustomTextField(placeholder: "Password")
    tf.isSecureTextEntry = true
    return tf
  }()
  
  // 로그인 버튼
  private let loginButton : UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Log In", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
    button.layer.cornerRadius = 5
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    button.isEnabled = false
    return button
  }()
  
  // forgetPassword 버튼
  private let forgotPasswordButton : UIButton = {
    let button = UIButton(type: .system)
    button.attributedTitle(firstString: "Forgot your password?", secondString: "Get help signing in")
    return button
  }()
  
  // dontHaveAccount 버튼 
  private let dontHaveAccountButton : UIButton = {
    let button = UIButton(type: .system)
    button.attributedTitle(firstString: "Don't have an account? ", secondString: "Sign Up")
    button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
    return button
  }()
  
  // LoginViewModel 생성
  private var viewModel = LoginViewModel()
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setNavi()
    configureUI()
    configureNotificationObservers()
  }
  
  //MARK: - Helpers
  private func setNavi() {
    navigationController?.navigationBar.isHidden = true // 네비게이션 바 없애기
    navigationController?.navigationBar.barStyle = .black // 네비게이션 시간 보여지는 곳에 라이트 모드이거나 다크 모두 둘다 하얀색으로 나온다.
  }
  
  private func configureUI() {
    configureGradientLayer()
    
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
  
  func configureNotificationObservers() {
    emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
  }
  //MARK: - @objc func
  @objc func handleShowSignUp() {
    let controller = RegistrationController()
    navigationController?.pushViewController(controller, animated: true)
  }
  
  @objc func textDidChange(sender : UITextField) {
    if sender == emailTextField {
      viewModel.email = sender.text
    } else {
      viewModel.password = sender.text
    }
    updateForm()
  }
}

  //MARK: - extension FormViewModel
extension LoginController : FormViewModel {
  func updateForm() {
    loginButton.backgroundColor = viewModel.buttonBackgroundColor
    loginButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
    loginButton.isEnabled = viewModel.formIsValid
  }
}
