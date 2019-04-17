//
//  ViewController.swift
//  AnyFormatKit
//
//  Created by luximetr on 10/31/2017.
//  Copyright (c) 2017 luximetr. All rights reserved.
//

import UIKit
import AnyFormatKit

class ViewController: UIViewController {
  // MARK: - Fields
  let textInputFieldController = TextInputController()
  let textInputViewController = TextInputController()
  let sumInputController = TextInputController()
  let phoneNumberField = TextInputField(frame: LayoutConstants.textInputFieldFrame)
  let cardNumberView = TextInputView(frame: LayoutConstants.textInputViewFrame)
  let sumInputField = TextInputField(frame: LayoutConstants.sumTextInputFieldFrame)
  
  let phoneNumberFormatter = TextInputFormatter(textPattern: "### (###) ###-##-##", prefix: "+12")
  let cardNumberFormatter = TextInputFormatter(textPattern: "XXXX XXXX XXXX XXXX", patternSymbol: "X")
  let sumFormatter = SumTextInputFormatter(textPattern: "#.###,# $")
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    initConfigure()
  }
}

// MARK: - Private
private extension ViewController {
  func initConfigure() {
    configureSelfView()
    configureTitleLabels()
    configureTextFields()
    configureTextView()
    configureFormatters()
    configureTextFieldControllers()
    configureTextViewController()
    setupFirstResponder()
  }
  
  func configureSelfView() {
    view.backgroundColor = UIColor.black
  }
  
  func configureTitleLabels() {
    let phoneNumberTitleLabel = UILabel(frame: LayoutConstants.phoneNumberLabelFrame)
    phoneNumberTitleLabel.textColor = UIColor.white
    phoneNumberTitleLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular )
    phoneNumberTitleLabel.text = "Phone number: "
    
    let cardNumberTitleLabel = UILabel(frame: LayoutConstants.cardNumberLabelFrame)
    cardNumberTitleLabel.textColor = UIColor.white
    cardNumberTitleLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
    cardNumberTitleLabel.text = "Card number: "
    
    let sumTitleLabel = UILabel(frame: LayoutConstants.sumLabelFrame)
    sumTitleLabel.textColor = UIColor.white
    sumTitleLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
    sumTitleLabel.text = "Enter sum: "
    
    view.addSubview(phoneNumberTitleLabel)
    view.addSubview(cardNumberTitleLabel)
    view.addSubview(sumTitleLabel)
  }
  
  func configureTextFields() {
    configurePhoneNumberField()
    configureSumInputField()
  }
  
  func configurePhoneNumberField() {
    view.addSubview(phoneNumberField)
    phoneNumberField.backgroundColor = UIColor.black
    phoneNumberField.tintColor = ColorConstants.gray
    
    phoneNumberField.textInputDelegates.add(delegate: self)
    phoneNumberField.defaultTextAttributes = [
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .regular)] as [NSAttributedString.Key : Any]
    phoneNumberField.addAttributes([.foregroundColor : ColorConstants.yellow], range: NSRange(location: 0, length: 3))
  }
  
  func configureSumInputField() {
    view.addSubview(sumInputField)
    sumInputField.backgroundColor = UIColor.black
    sumInputField.tintColor = ColorConstants.gray
    
    sumInputField.textInputDelegates.add(delegate: self)
    sumInputField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    sumInputField.defaultTextAttributes = [
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .regular)] as [NSAttributedString.Key : Any]
    sumInputField.addAttributes([.foregroundColor : ColorConstants.yellow], range: NSRange(location: 0, length: 2))
  }

  @objc
  func textDidChange(_ field: UITextField) {
    print("textDidChange \(field)")
  }
  
  func configureTextView() {
    configureCardNumberView()
  }
  
  func configureCardNumberView() {
    view.addSubview(cardNumberView)
    cardNumberView.backgroundColor = UIColor.black
    cardNumberView.tintColor = ColorConstants.gray
    
    cardNumberView.typingAttributes = [
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .regular),
        NSAttributedString.Key.foregroundColor: UIColor.white]  as [NSAttributedString.Key : Any]
    cardNumberView.addAttributes([.foregroundColor : ColorConstants.yellow], range: NSRange(location: 0, length: 4))
  }
  
  func configureFormatters() {
    phoneNumberFormatter.allowedSymbolsRegex = "[0-9]"
    cardNumberFormatter.allowedSymbolsRegex = "[0-9]"
    sumFormatter.allowedSymbolsRegex = "[0-9.,]"
  }
  
  func configureTextFieldControllers() {
    textInputFieldController.textInput = phoneNumberField
    textInputFieldController.formatter = phoneNumberFormatter
    
    sumInputController.textInput = sumInputField
    sumInputController.formatter = sumFormatter
    sumInputField.content = sumFormatter.formattedText(from: "")
  }
  
  func configureTextViewController() {
    textInputViewController.textInput = cardNumberView
    textInputViewController.formatter = cardNumberFormatter
    
    textInputViewController.setAndFormatText("4111012345672390")
  }
  
  func setupFirstResponder() {
    _ = phoneNumberField.becomeFirstResponder()
  }
}

// MARK: - TextInputDelegate
extension ViewController: TextInputDelegate {
  func textInputDidBeginEditing(_ textInput: TextInput) {
    print("textInputDidBeginEditing")
  }
  
  func textInputShouldBeginEditing(_ textInput: TextInput) -> Bool {
    return true
  }
}

// MARK: - Constants
private struct LayoutConstants {
  static let textInputFieldFrame = CGRect(x: 20, y: 65, width: UIScreen.main.bounds.width - 40, height: 40)
  static let textInputViewFrame = CGRect(x: 16, y: 165, width: UIScreen.main.bounds.width - 40, height: 40)
  static let sumTextInputFieldFrame = CGRect(x: 20, y: 265, width: UIScreen.main.bounds.width - 40, height: 40)
  static let phoneNumberLabelFrame = CGRect(x: 20, y: 40, width: UIScreen.main.bounds.width - 40, height: 20)
  static let cardNumberLabelFrame = CGRect(x: 20, y: 140, width: UIScreen.main.bounds.width - 40, height: 20)
  static let sumLabelFrame = CGRect(x: 20, y: 240, width: UIScreen.main.bounds.width - 40, height: 20)
}

private struct ColorConstants {
  static let yellow = UIColor(red: 255 / 255, green: 236 / 255, blue: 0 / 255, alpha: 1.0)
  static let gray = UIColor(red: 63 / 255, green: 63 / 255, blue: 63 / 255, alpha: 1.0)
}
