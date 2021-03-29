//
//  CShortlistedJobTableViewCell.swift
//  NSS
//
//  Created by Gowma on 21/03/21.
//

import UIKit

class CShortlistedJobTableViewCell: UITableViewCell {
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblJobTitle: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblNoofRating: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblSuccessfulJobs: UILabel!
    @IBOutlet weak var lblAppliedDate: UILabel!
    @IBOutlet weak var lblFixedPrice: UILabel!
    @IBOutlet weak var btnReject: UIButton!
    @IBOutlet weak var btnHire: UIButton!
    @IBOutlet weak var btnContractFreelancer: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewBg.layer.borderWidth = 0.5
        viewBg.layer.borderColor = UIColor.lightGray.cgColor
        viewBg.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        viewBg.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        viewBg.layer.shadowOpacity = 0.5
        viewBg.layer.shadowRadius = 3.0
        viewBg.layer.masksToBounds = false
        viewBg.layer.cornerRadius = 0.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
