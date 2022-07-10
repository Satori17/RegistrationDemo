//
//  BottomSheetVC.swift
//  Saba_Khitaridze_Task_14
//
//  Created by Saba Khitaridze on 09.07.22.
//

import UIKit

class BottomSheetVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noButton.layer.cornerRadius = noButton.frame.height/2
        yesButton.layer.cornerRadius = yesButton.frame.height/2
    }
    
//MARK: - IBActions
    
    @IBAction func noBtnPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func yesBtnPressed(_ sender: UIButton) {
        presentingViewController?.presentingViewController?.dismiss(animated: true)
        
        //also it can be done with "navigationController?.popToRootViewController(animated: true)" logic if I would go through that path from the beginning, but it will create top left button '< back' which was unacceptable.
    }    
}
