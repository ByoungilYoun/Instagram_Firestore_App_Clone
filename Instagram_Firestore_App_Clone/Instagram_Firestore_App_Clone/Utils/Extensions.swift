//
//  Extensions.swift
//  Instagram_Firestore_App_Clone
//
//  Created by 윤병일 on 2021/03/28.
//

import UIKit

extension UIButton {
  func attributedTitle(firstString : String, secondString : String) {
    
    let atts : [NSAttributedString.Key : Any] = [.foregroundColor : UIColor(white: 1, alpha: 0.87), .font : UIFont.systemFont(ofSize: 16)]
    let attributedTitle = NSMutableAttributedString(string: "\(firstString) ", attributes: atts)
    let boldAtts : [NSAttributedString.Key : Any] = [.foregroundColor : UIColor(white: 1, alpha: 0.87), .font : UIFont.boldSystemFont(ofSize: 16)]
    attributedTitle.append(NSAttributedString(string: secondString, attributes: boldAtts))
    
    setAttributedTitle(attributedTitle, for: .normal)
  }
}
