//
//  TitleView.swift
//  Saba_Khitaridze_Task_14
//
//  Created by Saba Khitaridze on 10.07.22.
//

import UIKit

class TitleView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        Bundle.main.loadNibNamed("TitleView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.layer.cornerRadius = contentView.frame.height/3.5
        contentView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        contentView.layer.shadowOffset = CGSize(width: 0, height: 10)
        contentView.layer.shadowRadius = 5
        contentView.layer.shadowOpacity = 0.3
    }
}
