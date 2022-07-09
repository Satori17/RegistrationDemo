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

class LoginVC: UIViewController {
    

    //MARK: - IBOutlets
    //labels
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    //textfields
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    
    //MARK: - Vars
    
    var username = ""
    var password = ""
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFieldDelegate()
        setupBackgroundTap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usernameTextField.text = username
        passwordTextField.text = password
    }

    
    //MARK: - IBActions
    
    @IBAction func signInBtnPressed(_ sender: UIButton) {
        
    }
    
    
    @IBAction func signUpBtnPressed(_ sender: UIButton) {        
        
    }
}


extension LoginVC: textFieldHelpers, UserAccountDelegate {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? RegisterVC
        if let destinationVC = destination {
            destinationVC.delegate = self
        }
    }
    
    func getUserDetails(from vc: RegisterVC) {
        vc.navigationController?.popViewController(animated: true)
        
        guard let usernameText = vc.usernameTextField.text, let passwordText = vc.passwordTextField.text else {
            print("error fetching text from textfield")
            return
        }
        username = usernameText
        password = passwordText
        print(username)
        print(password)
    }
    
    
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
            usernameLabel.text = textField.hasText ? "Username" : ""
        case passwordTextField:
            passwordLabel.text = textField.hasText ? "Password" : ""
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
