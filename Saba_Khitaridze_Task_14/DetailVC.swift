//
//  DetailVC.swift
//  Saba_Khitaridze_Task_14
//
//  Created by Saba Khitaridze on 09.07.22.
//

import UIKit

class DetailVC: UIViewController {

    //MARK: - IBOutlets
    //labels
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    //uiview
    @IBOutlet weak var detailView: TitleView! {
        didSet {
            detailView.titleLabel.text = "Welcome, \(accountName)!"
        }
    }
    
    
    //MARK: - Vars
    var accountName = ""
    var accountEmail = ""
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameLabel.text = accountName
        emailLabel.text = accountEmail
    }
    
    //MARK: - IBAction
    @IBAction func signOutBtnPressed(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BottomSheetVC")
        present(vc, animated: true)
    }
}
