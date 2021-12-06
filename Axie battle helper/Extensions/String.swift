//



//  Created by Allegion on 12/11/2021



//  Copyright © 2021 Allegion. All rights reserved.



//  

import Foundation

extension String {

  var localized: String {
    return NSLocalizedString(self, comment: "\(self)_comment")
  }
  
  func localized(_ args: [CVarArg]) -> String {
    return localized(args)
  }
  
  func localized(_ args: CVarArg...) -> String {
    return String(format: localized, args)
  }
}
