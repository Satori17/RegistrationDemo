//
//  LoginVC.swift
//  Saba_Khitaridze_Task_14
//
//  Created by Saba Khitaridze on 09.07.22.
//

import UIKit

protocol textFieldHelpers {
    func setupTextFieldDelegate()
    func textFieldDidChange(_ textField: UITextField)
    func updatePlaceHolderLabel(of textField: UITextField)
    func setupBackgroundTap()
    func backgroundTap()
}

enum InputType: String {
    case Username
    case Email
    case Password
    case Confirm = "Confirm password"
}


class LoginVC: UIViewController {
    

    //MARK: - IBOutlets
    //labels
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    //textfields
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    //uiview
    @IBOutlet weak var loginView: TitleView! {
        didSet {
            loginView.titleLabel.text = "Login"
        }
    }
    
    
    //MARK: - Vars
    private var username = ""
    private var email = ""
    private var password = ""
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFieldDelegate()
        setupBackgroundTap()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //clearing password textfields when user logs out
        passwordTextField.text = ""
        passwordLabel.text = ""
    }
    
    //MARK: - IBAction
    
    @IBAction func signInBtnPressed(_ sender: UIButton) {
        signInHelper(check: usernameTextField.text == username && passwordTextField.text == password)
    }
    
    
    //MARK: - Methods
    
    private func signInHelper(check condition: Bool) {
        if condition {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailVC") as? DetailVC
            if let destinationVC = vc {
                destinationVC.accountName = username
                destinationVC.accountEmail = email
                destinationVC.modalPresentationStyle = .fullScreen
                present(destinationVC, animated: true)
            }
        } else {
            let alert = UIAlertController(title: "Incorrect Credentials", message: "Your username or password is incorrect. Please try again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
            present(alert, animated: true)
        }
    }
}


extension LoginVC: textFieldHelpers, UserAccountDelegate {
    
    //UserAccountDelegate
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? RegisterVC
        if let destinationVC = destination {
            destinationVC.delegate = self
        }
    }
    
    func getUserDetails(from vc: RegisterVC) {
        vc.navigationController?.popViewController(animated: true)
        
        guard let usernameText = vc.usernameTextField.text, let emailText = vc.emailTextField.text, let passwordText = vc.passwordTextField.text else {
            print("error fetching text from textfield")
            return
        }
        username = usernameText
        email = emailText
        password = passwordText
    }
    
    //textFieldHelpers
    func setupTextFieldDelegate() {
        usernameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        updatePlaceHolderLabel(of: textField)
    }
    
    func updatePlaceHolderLabel(of textField: UITextField) {
        switch textField {
        case usernameTextField:
            usernameLabel.text = textField.hasText ? InputType.Username.rawValue : ""
        case passwordTextField:
            passwordLabel.text = textField.hasText ? InputType.Password.rawValue : ""
        default:
            usernameLabel.text = ""
            passwordLabel.text = ""
        }
    }
    
    //helper method when user taps on screen, keyboard will disappear
    func setupBackgroundTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func backgroundTap() {
        view.endEditing(false)
    }
}
