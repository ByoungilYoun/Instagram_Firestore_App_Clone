//
//  UploadPostController.swift
//  Instagram_Firestore_App_Clone
//
//  Created by 윤병일 on 2021/05/02.
//

import UIKit

protocol UploadPostControllerDelegate : AnyObject {
  func controllerDidFinishUploadingPost(_ controller : UploadPostController)
}

class UploadPostController : UIViewController {
  
  //MARK: - Properties
  
  weak var delegate : UploadPostControllerDelegate?
  
  var currentUser : User?
  
  var selectedImage : UIImage? {
    didSet {
      photoImageView.image = selectedImage
    }
  }
  
  private let photoImageView : UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    return iv
  }()
  
  private lazy var captionTextView : InputTextView = {
    let tv = InputTextView()
    tv.placeholderText = "Enter caption.."
    tv.textColor = .black
    tv.font = UIFont.systemFont(ofSize: 16)
    tv.delegate = self
    return tv
  }()
  
  
  private let characterCountLabel : UILabel = {
    let label = UILabel()
    label.textColor = .lightGray
    label.font = UIFont.systemFont(ofSize: 14)
    label.text = "0 / 100"
    return label
  }()
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setNavi()
    setUI()
  }
  
  //MARK: - Functions
  private func setNavi() {
    view.backgroundColor = .white
    navigationItem.title = "Upload Post"
    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel))
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .done, target: self, action: #selector(didTapDone))
  }
  
  private func setUI() {
    photoImageView.layer.cornerRadius = 10
    
    [photoImageView, captionTextView, characterCountLabel].forEach {
      view.addSubview($0)
    }
    
    photoImageView.snp.makeConstraints {
      $0.width.height.equalTo(180)
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
      $0.centerX.equalToSuperview()
    }
    
    captionTextView.snp.makeConstraints {
      $0.top.equalTo(photoImageView.snp.bottom).offset(16)
      $0.leading.equalToSuperview().offset(12)
      $0.trailing.equalToSuperview().offset(-12)
      $0.height.equalTo(80)
    }
    
    characterCountLabel.snp.makeConstraints {
      $0.top.equalTo(captionTextView.snp.bottom)
      $0.trailing.equalTo(captionTextView.snp.trailing)
    }
  }
  
  // 글자수 100자 제한하는 함수
  func checkMaxLength(_ textView : UITextView) {
    if (textView.text.count) > 100 {
      textView.deleteBackward()
    }
  }
  
  //MARK: - @objc func
  @objc func didTapCancel() {
    dismiss(animated: true, completion: nil)
  }
  
  @objc func didTapDone() {
    guard let image = selectedImage else {return}
    guard let caption = captionTextView.text else {return}
    guard let user = currentUser else {return}
    showLoader(true)
    
    PostService.uploadPost(caption: caption, image: image, user: user) { error in
      self.showLoader(false)
      if let error = error {
        print("Debug : Failed to upload post with error \(error.localizedDescription)")
        return
      }
      
      self.delegate?.controllerDidFinishUploadingPost(self)
    }
  }
}

//MARK: - extension UITextViewDelegate
extension UploadPostController : UITextViewDelegate {
  func textViewDidChange(_ textView: UITextView) {
    checkMaxLength(textView)
    let count = textView.text.count
    characterCountLabel.text = "\(count) / 100"
  }
}
