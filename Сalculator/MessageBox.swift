//
//  MessageBox.swift
//  Сalculator
//
//  Created by Dmitry on 24.09.17.
//  Copyright © 2017 Dmitry. All rights reserved.
//

import Foundation
import UIKit

class MessageBox {
    
    static func showMessage (message: String) {
        
        let parrent = UIApplication.topViewController()
        
        let alertController = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        parrent?.present(alertController, animated: true, completion: nil)
    }
}
