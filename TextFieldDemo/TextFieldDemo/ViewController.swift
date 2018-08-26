//
//  ViewController.swift
//  TextFieldDemo
//
//  Created by Josscii on 2018/8/25.
//  Copyright © 2018 Josscii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var textFiled: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        textFiled = UITextField(frame: CGRect(x: 50, y: 200, width: 200, height: 50))
        view.addSubview(textFiled)
        textFiled.delegate = self
        textFiled.keyboardType = .numberPad
        textFiled.backgroundColor = .red
        
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidChange(notification:)), name: .UITextFieldTextDidChange, object: nil)
    }
    
    var isDeleting = false
    var isPasting = false
}

extension UITextField {
    func setCursor(position: Int) {
        let position = self.position(from: beginningOfDocument, offset: position)!
        selectedTextRange = textRange(from: position, to: position)
    }
}

extension ViewController: UITextFieldDelegate {
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        var currentText = textFiled.text ?? ""
//
//        var finalText = ""
//        currentText = currentText.replacingOccurrences(of: " ", with: "") + string.replacingOccurrences(of: " ", with: "")
//
//        for i in 0..<currentText.count {
//            let index = currentText.index(currentText.startIndex, offsetBy: i)
//            let c = currentText[index]
//
//            if currentText.count > 3 {
//                if index == currentText.index(currentText.startIndex, offsetBy: 3) {
//                    finalText.append(" ")
//                }
//            }
//
//            if currentText.count > 7 {
//                if index == currentText.index(currentText.startIndex, offsetBy: 7) {
//                    finalText.append(" ")
//                }
//            }
//
//            finalText.append(c)
//        }
//
//        if finalText.count > 13 {
//            finalText = String(finalText[finalText.startIndex..<finalText.index(finalText.startIndex, offsetBy: 13)])
//        }
//
//        textFiled.text = finalText
//        textField.setCursor(position: range.location)
//
//        return false
//    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        isDeleting = string == ""
        isPasting = string.count > 1
        
        return true
    }
    
    @objc
    func textFieldDidChange(notification: Notification) {
        var currentText = textFiled.text ?? ""
        var selectedRange = textFiled.selectedTextRange

        var finalText = ""
        currentText = currentText.replacingOccurrences(of: " ", with: "")

        for i in 0..<currentText.count {
            let index = currentText.index(currentText.startIndex, offsetBy: i)
            let c = currentText[index]

            if currentText.count > 3 {
                if index == currentText.index(currentText.startIndex, offsetBy: 3) {
                    finalText.append(" ")
                }
            }

            if currentText.count > 7 {
                if index == currentText.index(currentText.startIndex, offsetBy: 7) {
                    finalText.append(" ")
                }
            }

            finalText.append(c)
        }
        
        if finalText.count > 13 {
            finalText = String(finalText[finalText.startIndex..<finalText.index(finalText.startIndex, offsetBy: 13)])
        }

        textFiled.text = finalText
        
        if !isDeleting {
            if finalText.count == 5 || finalText.count == 10 {
                selectedRange = textFiled.textRange(from: textFiled.endOfDocument, to: textFiled.endOfDocument)
            }
        }
        
        if isPasting {
            selectedRange = textFiled.textRange(from: textFiled.endOfDocument, to: textFiled.endOfDocument)
        }
        
        DispatchQueue.main.async {
            self.textFiled.selectedTextRange = selectedRange
        }
    }
}

