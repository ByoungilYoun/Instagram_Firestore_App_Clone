//
//  UploadPostController.swift
//  Instagram_Firestore_App_Clone
//
//  Created by 윤병일 on 2021/05/02.
//

import UIKit

class UploadPostController : UIViewController {
  
  //MARK: - Properties
  private let photoImageView : UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFill
    iv.image = #imageLiteral(resourceName: "venom-7")
    iv.clipsToBounds = true
    return iv
  }()
  
  private let captionTextView : UITextView = {
    let tv = UITextView()
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
  
  //MARK: - @objc func
  @objc func didTapCancel() {
    dismiss(animated: true, completion: nil)
  }
  
  @objc func didTapDone() {
    print("Debug : Share post here...")
  }
}
