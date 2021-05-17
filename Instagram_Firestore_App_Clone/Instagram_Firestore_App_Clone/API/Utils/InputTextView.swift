//
//  InputTextView.swift
//  Instagram_Firestore_App_Clone
//
//  Created by 윤병일 on 2021/05/02.
//

import UIKit

class InputTextView : UITextView {
  
  //MARK: - Properties
  
  var placeholderText : String? {
    didSet {
      placeholderLabel.text = placeholderText
    }
  }
  
   let placeholderLabel : UILabel = {
    let label = UILabel()
    label.textColor = .lightGray
    return label
  }()
  
  var placeholderShouldCenter = true {
    didSet {
      if placeholderShouldCenter {
        placeholderLabel.snp.remakeConstraints {
          $0.leading.equalToSuperview().offset(8)
          $0.trailing.equalToSuperview()
          $0.centerY.equalToSuperview()
          }
      } else {
        placeholderLabel.snp.remakeConstraints {
          $0.top.equalToSuperview().offset(6)
          $0.leading.equalToSuperview().offset(8)
        }
      }
    }
  }
  //MARK: - Lifecycle
  override init(frame: CGRect, textContainer: NSTextContainer?) {
    super.init(frame: frame, textContainer: textContainer)
    setUI()
    
    NotificationCenter.default.addObserver(self, selector: #selector(handleTextDidChange), name: UITextView.textDidChangeNotification, object: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Functions
  private func setUI() {
    backgroundColor = .white
    addSubview(placeholderLabel)
    
    placeholderLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(6)
      $0.leading.equalToSuperview().offset(8)
    }
  }
  
  //MARK: - @objc func
  @objc func handleTextDidChange() {
    placeholderLabel.isHidden = !text.isEmpty
  }
}
