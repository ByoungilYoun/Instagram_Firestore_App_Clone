//
//  CommentInputAccessoryView.swift
//  Instagram_Firestore_App_Clone
//
//  Created by 윤병일 on 2021/05/17.
//

import UIKit

protocol CommentInputAccessoryViewDelegate : AnyObject {
  func inputView(_ inputView : CommentInputAccessoryView, wantsToUploadComment comment : String)
}

class CommentInputAccessoryView : UIView {
  
  //MARK: - Properties
  
  weak var delegate : CommentInputAccessoryViewDelegate?
  
  private let commentTextView : InputTextView = {
    let tv = InputTextView()
    tv.placeholderText = "Enter comment..."
    tv.font = UIFont.systemFont(ofSize: 15)
    tv.isScrollEnabled = false
    tv.placeholderShouldCenter = true
    tv.textColor = .black
    return tv
  }()
  
  private let postButton : UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Post", for: .normal)
    button.setTitleColor(.black, for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    button.addTarget(self, action: #selector(handlePostTapped), for: .touchUpInside)
    return button
  }()
  
  let divider = UIView()
  //MARK: - Lifecycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Functions
  private func setUI() {
    autoresizingMask = .flexibleHeight
    backgroundColor = .white // 뒷배경 white 를 줌으로써 커멘트가 accessoryview 뒤에 있어도 안보인다.
    
    [commentTextView, postButton, divider].forEach {
      addSubview($0)
    }
    
    commentTextView.snp.makeConstraints {
      $0.top.equalTo(self.snp.top).offset(8)
      $0.leading.equalTo(self.snp.leading).offset(8)
      $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-8)
      $0.trailing.equalTo(postButton.snp.leading).offset(8)
    }
    
    postButton.snp.makeConstraints {
      $0.top.equalTo(self.snp.top)
      $0.trailing.equalTo(self.snp.trailing).offset(-8)
      $0.width.height.equalTo(50)
    }
    
    divider.backgroundColor = .lightGray
    
    divider.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview()
      $0.height.equalTo(0.5)
    }
    
  }
  
  override var intrinsicContentSize: CGSize {
    return .zero
  }
  
  // 글자 없애는 함수 
  func clearCommentTextView() {
    commentTextView.text = nil
    commentTextView.placeholderLabel.isHidden = false
  }
  
  //MARK: - @objc func
  @objc func handlePostTapped() {
    delegate?.inputView(self, wantsToUploadComment: commentTextView.text)
  }
}
