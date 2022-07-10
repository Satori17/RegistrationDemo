//
//  RegisterVC.swift
//  Saba_Khitaridze_Task_14
//
//  Created by Saba Khitaridze on 09.07.22.
//

import UIKit

protocol UserAccountDelegate {
    func getUserDetails(from vc: RegisterVC)
}

class RegisterVC: UIViewController {

    //MARK: - IBOutlets
    //labels
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var confirmPasswordLabel: UILabel!
    //textfields
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    //uiview
    @IBOutlet weak var registerView: TitleView! {
        didSet {
            registerView.titleLabel.text = "Register"
        }
    }
    
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .white
        setupTextFieldDelegate()
        setupBackgroundTap()
    }
    
    //MARK: - Vars
    
    private var isEveryTextCorrectlyFilled = false
    var delegate: UserAccountDelegate?
    
    //MARK: - IBAction
    
    @IBAction func signUpBtnPressed(_ sender: UIButton) {
        let textFields = [usernameTextField, emailTextField, passwordTextField, confirmPasswordTextField]
        textFields.forEach({
            if let textField = $0 {
                isTextInputed(in: textField)
            }
        })
        if isEveryTextCorrectlyFilled { delegate?.getUserDetails(from: self) }
    }
    
    //MARK: - Methods
    
    private func isTextInputed(in textField: UITextField) {
        if usernameTextField.hasText, emailTextField.hasText, passwordTextField.hasText, confirmPasswordTextField.hasText {
                validatePassword(check: passwordTextField.text == confirmPasswordTextField.text)
        } else if !textField.hasText {
            switch textField {
            case usernameTextField:
                    usernameLabel.textColor = .red
                    usernameLabel.text = "*required"
            case emailTextField:
                    emailLabel.textColor = .red
                    emailLabel.text = "*required"
            case passwordTextField:
                    passwordLabel.textColor = .red
                    passwordLabel.text = "*required"
            case confirmPasswordTextField:
                    confirmPasswordLabel.textColor = .red
                    confirmPasswordLabel.text = "*required"
            default:
                print("error checking textFields")
            }
        }
    }
    
    //password validation checker
    private func isValid(password: String?) -> Bool {
        let passwordRegEx = "^(?=.*[a-z])(?=.*[0-9])(?=.*[A-Z]).{8,}$"
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordPred.evaluate(with: password)
    }
    
    private func getAlert(with title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(alert, animated: true)
    }
    
    private func validatePassword(check condition: Bool) {
        condition ? (isValid(password: passwordTextField.text) ? isEveryTextCorrectlyFilled = true : getAlert(with: "This password is not secure")) : getAlert(with: "Passwords doesn't match")
    }
}


extension RegisterVC: textFieldHelpers {
    
    func setupTextFieldDelegate() {
        usernameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        confirmPasswordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        updatePlaceHolderLabel(of: textField)
    }
    
    func updatePlaceHolderLabel(of textField: UITextField) {
        switch textField {
        case usernameTextField:
            usernameLabel.text = textField.hasText ? InputType.Username.rawValue : ""
            usernameLabel.textColor = .lightGray
        case emailTextField:
            emailLabel.text = textField.hasText ? InputType.Email.rawValue : ""
            emailLabel.textColor = .lightGray
        case passwordTextField:
            passwordLabel.text = textField.hasText ? InputType.Password.rawValue : ""
            passwordLabel.textColor = .lightGray
        case confirmPasswordTextField:
            confirmPasswordLabel.text = textField.hasText ? InputType.Confirm.rawValue : ""
            confirmPasswordLabel.textColor = .lightGray
        default:
            usernameLabel.text = ""
            emailLabel.text = ""
            passwordLabel.text = ""
            confirmPasswordLabel.text = ""
        }
    }
    
    func setupBackgroundTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func backgroundTap() {
        view.endEditing(false)
    }
}
