//
//  ViewController.swift
//  testTask
//
//  Created by Edgar Sargsyan on 18.10.23.
//

import UIKit
import WebKit

class Page3: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var buttonLabel: UILabel!
    @IBOutlet weak var timerTextField: UITextField!
    @IBOutlet weak var moneyTexField: UITextField!
    @IBOutlet weak var webView: WKWebView!
    
    @IBAction func buyButton(_ sender: Any) {
       if let stake = Int(moneyTexField.text ?? "0") {
        if stake > 0 && stake <= balanceValue {
                        showAlert(message: "Successfully")
                        balanceValue -= stake
        let isWin = Int.random(in: 1...2) == 1
                        if isWin {
        let winnings = Int(Double(stake) * 0.7)
                        balanceValue += winnings
                              }
                        moneyTexField.text = String(balanceValue)
                    } else {
                        showAlert(message: "Invalid stake")
                    }
               }
          }
    
    @IBAction func moneyButton(_ sender: Any) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Page4") as? Page4 {
            vc.delegate = self
            vc.selectedIndex = selectedIndex ?? 1
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func timerMinusButton(_ sender: Any) {
        if let timeComponents = timerTextField.text?.split(separator: ":"), timeComponents.count == 2,
                var hours = Int(timeComponents[0]), var minutes = Int(timeComponents[1]) {
                minutes -= 1
                if minutes < 0 {
            
                    hours -= 1
                    minutes = 59
                }
                timerTextField.text = String(format: "%02d:%02d", hours, minutes)
            }
        }
    
    @IBAction func timerPluseButton(_ sender: Any) {
        if let timeComponents = timerTextField.text?.split(separator: ":"), timeComponents.count == 2,
                var hours = Int(timeComponents[0]), var minutes = Int(timeComponents[1]) {
                minutes += 1
                if minutes >= 60 {
                 
                    hours += 1
                    minutes = 0
                }
                timerTextField.text = String(format: "%02d:%02d", hours, minutes)
            }
        }
     func formatTime(_ timeInSeconds: Int) -> String {
         let hours = timeInSeconds / 3600
         let minutes = (timeInSeconds % 3600) / 60
         return String(format: "%02d:%02d", hours, minutes)
     }
    
    @IBAction func moneyMinusButton(_ sender: Any) {
        if var currentBalance = Int(moneyTexField.text ?? "0") {
                currentBalance -= 100
                if currentBalance < 0 {
                    currentBalance = 0
                }
                moneyTexField.text = String(currentBalance)
            }
        }

    @IBAction func moneyPlusButton(_ sender: Any) {
    if var currentBalance = Int(moneyTexField.text ?? "0") {
               currentBalance += 100
               moneyTexField.text = String(currentBalance)
           }
    }
    
private var selectedIndex: Int?
        var currentTime = 0
        var balanceValue = 10000
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Result", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func updateBalance(_ newBalance: Int) {
        balanceValue = newBalance
        let labelText = "Balance"
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal

     if let formattedBalance = numberFormatter.string(from: NSNumber(value: newBalance)) {
        let combinedText = "\(labelText)\n\(formattedBalance)"
        let attributedText = NSMutableAttributedString(string: combinedText)
        let balanceAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 14),
                .foregroundColor: UIColor.gray
            ]
            attributedText.addAttributes(balanceAttributes, range: (combinedText as NSString).range(of: labelText))

            balanceLabel.attributedText = attributedText
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //unclick webView
         webView.isUserInteractionEnabled = false
       
       
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)

     
        moneyTexField.text = "1000"
        timerTextField.isUserInteractionEnabled = true
        timerTextField.isEnabled = true
        timerTextField.delegate = self
        moneyTexField.delegate = self
        
        loadRequest()
        currentTime = 60
           
        let labelText = "Balance"
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        if let formattedBalance = numberFormatter.string(from: NSNumber(value: balanceValue)) {
            
        let combinedText = "\(labelText)\n\(formattedBalance)"
            
        let attributedText = NSMutableAttributedString(string: combinedText)
        let balanceAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 14),
                .foregroundColor: UIColor.gray
            ]
            attributedText.addAttributes(balanceAttributes, range: (combinedText as NSString).range(of: labelText))
            
            balanceLabel.attributedText = attributedText
            balanceLabel.numberOfLines = 0
            balanceLabel.textAlignment = .center
        }
  
           let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
          
           scrollView.addGestureRecognizer(tapGesture)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
  
   @objc func keyboardWillShow(_ notification: Notification) {

        
        if let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            let keyboardHeight = keyboardFrame.height
            let contentInsets = UIEdgeInsets(top: -130, left: 0, bottom: keyboardHeight, right: 0)

             scrollView.contentInset = contentInsets
             scrollView.scrollIndicatorInsets = contentInsets
        }
    }
 
    @objc func keyboardWillHide(_ notification: Notification) {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
    
    private func loadRequest() {
        guard let url = URL(string: "https://www.tradingview.com/chart") else { return }
        let  urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
}

extension Page3: Page4DataPassDelegate {
    func passInfo(info: SelectedInfoModel) {
        selectedIndex = info.selectedIndex
        buttonLabel.text = info.info
    }
}

extension Page3: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet(charactersIn: "0123456789:")
        let characterSet = CharacterSet(charactersIn: string)
        if let currentText = textField.text, let currentValue = Int(currentText + string), currentValue <= balanceValue, allowedCharacters.isSuperset(of: characterSet) {
                    return true
               }
               
               return false
    }
}
