//
//  ParstView.swift
//  Axie battle helper
//
//  Created by Alejandro de Jesus on 30/12/2021.
//

import Foundation

extension String {

  var localized: String {
    return NSLocalizedString(self, comment: "\(self)_comment")
  }
  
  func localized(_ args: CVarArg...) -> String {
    return String(format: localized, args)
  }
}
