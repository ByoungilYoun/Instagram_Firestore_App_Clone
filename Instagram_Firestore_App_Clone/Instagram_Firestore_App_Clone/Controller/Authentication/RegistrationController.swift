//
//  RegistrationController.swift
//  Instagram_Firestore_App_Clone
//
//  Created by 윤병일 on 2021/03/28.
//

import UIKit

class RegistrationController : UIViewController {
  
  //MARK: - Properties
  
  private let plusPhotoButton : UIButton = {
    let button = UIButton(type: .system)
    button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
    button.tintColor = .white
    button.addTarget(self, action: #selector(handleProfilePhotoSelect), for: .touchUpInside)
    return button
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
  
  // 풀네임 텍스트 필드
  private let fullnameTextField = CustomTextField(placeholder: "Fullname")
  
  // 유저 네임 텍스트 필드
  private let usernameTextField = CustomTextField(placeholder: "Username")

  // Sign Up 버튼
  private let signUpButton : UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Sign Up", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
    button.layer.cornerRadius = 5
    button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    button.isEnabled = false
    return button
  }()
  
  // already have account 버튼
  private let alreadyHaveAccountButton : UIButton = {
    let button = UIButton(type: .system)
    button.attributedTitle(firstString: "Already have an account? ", secondString: "Log In")
    button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
    return button
  }()
  
  private var viewModel = RegistrationViewModel() 
  
  private var profileImage : UIImage?
  //MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    configureNotificationObservers()
  }
  
  //MARK: - Helpers
  func configureUI() {
    configureGradientLayer()
    
    [plusPhotoButton].forEach {
      view.addSubview($0)
    }
    
    plusPhotoButton.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(32)
      $0.width.height.equalTo(140)
    }
    
    [emailTextField, passwordTextField, fullnameTextField, usernameTextField, signUpButton].forEach {
      $0.snp.makeConstraints {
        $0.height.equalTo(40)
      }
    }
    
    let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, fullnameTextField, usernameTextField, signUpButton])
    stack.axis = .vertical
    stack.spacing = 20
    view.addSubview(stack)
    
    stack.snp.makeConstraints {
      $0.top.equalTo(plusPhotoButton.snp.bottom).offset(32)
      $0.leading.equalToSuperview().offset(32)
      $0.trailing.equalToSuperview().offset(-32)
    }
    
    view.addSubview(alreadyHaveAccountButton)
    alreadyHaveAccountButton.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
    }
  }
  
  func configureNotificationObservers() {
    emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    fullnameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    usernameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
  }
  
  //MARK: - @objc func
  @objc func handleShowLogin() {
    navigationController?.popViewController(animated: true)
  }
  
  @objc func textDidChange(sender : UITextField) {
    if sender == emailTextField {
      viewModel.email = sender.text
    } else if sender == passwordTextField {
      viewModel.password = sender.text
    } else if sender == fullnameTextField {
      viewModel.fullname = sender.text
    } else {
      viewModel.username = sender.text
    }
    updateForm()
  }
  
  @objc func handleProfilePhotoSelect() {
    let picker = UIImagePickerController()
    picker.delegate = self
    picker.allowsEditing = true
    
    present(picker, animated: true, completion: nil)
  }
  
  // 여기서 중요한거 textField의 text 는 항상 기본적으로 optional 이기 때문에 풀어주기 위해서 guard 문을 써준면 좋다.
  @objc func handleSignUp() {
    guard let email = emailTextField.text else {return}
    guard let password = passwordTextField.text else {return}
    guard let fullname = fullnameTextField.text else {return}
    guard let username = usernameTextField.text?.lowercased() else {return}
    guard let profileImage = self.profileImage else {return} // self.profileImage 에서 self를 안붙여줘도 되지만 구별하기 위해 써준다.
    
    let credentials = AuthCredentials(email: email, password: password, fullname: fullname, username: username, profileImage: profileImage)
  
    AuthService.registerUser(withCredentials: credentials) { error in
      if let error = error {
        print("Debug : Failed to register user : \(error.localizedDescription)")
        return
      }
      self.dismiss(animated: true, completion: nil)
    }
  }
}

 //MARK: - extension FormViewModel
extension RegistrationController : FormViewModel {
  func updateForm() {
    signUpButton.backgroundColor = viewModel.buttonBackgroundColor
    signUpButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
    signUpButton.isEnabled = viewModel.formIsValid
  }
}

  //MARK: - extension UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension RegistrationController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let selectedImage = info[.editedImage] as? UIImage else {return}
    
    profileImage = selectedImage // 위에 변수로 profileImage 를 옵셔널로 만들고 이미지 피커 컨트롤로 이미지를 선택했을때 그 이미지를 profileImage 변수에 넣어준다.
    
    plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width / 2
    plusPhotoButton.layer.masksToBounds = true
    plusPhotoButton.layer.borderColor = UIColor.white.cgColor
    plusPhotoButton.layer.borderWidth = 2
    plusPhotoButton.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
    self.dismiss(animated: true, completion: nil)
  }
}
