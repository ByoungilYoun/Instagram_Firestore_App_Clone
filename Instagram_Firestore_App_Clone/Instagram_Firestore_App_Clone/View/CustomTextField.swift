//
//  CustomTextField.swift
//  Instagram_Firestore_App_Clone
//
//  Created by 윤병일 on 2021/03/28.
//

import UIKit

class CustomTextField : UITextField {
  
  //MARK: - init
   init(placeholder: String) {
    super.init(frame: .zero)
    let spacer = UIView()
    
    spacer.snp.makeConstraints {
      $0.height.equalTo(50)
      $0.width.equalTo(12)
    }
    
    leftView = spacer
    leftViewMode = .always // 왼쪽 스페이싱을 뷰로 줘서 띄어지게 보이게한다. 
    
    
    borderStyle = .none
    textColor = .white
    keyboardAppearance = .dark
    backgroundColor = UIColor(white: 1, alpha: 0.1)
    attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor : UIColor(white: 1, alpha: 0.7)])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
