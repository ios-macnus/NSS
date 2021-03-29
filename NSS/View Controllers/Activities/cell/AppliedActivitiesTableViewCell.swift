//
//  AppliedActivitiesTableViewCell.swift
//  NSS
//
//  Created by Gowma on 19/02/21.
//

import UIKit

class AppliedActivitiesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewBg: UIView!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblClientName: UILabel!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblDateOfWork: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewBg.layer.borderColor = UIColor.darkGray.cgColor
        viewBg.layer.borderWidth = 1.0
        
        viewBg.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.45).cgColor
        viewBg.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewBg.layer.shadowOpacity = 0.5
        viewBg.layer.shadowRadius = 3.0
        viewBg.layer.masksToBounds = false
        viewBg.layer.cornerRadius = 2.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var data: jobActivitiesListDataResponse? {
        didSet {
            lblTitle.text = data?.job_title
            lblClientName.text = data?.client_user_name
            lblInfo.text = "\(data?.job_requirement ?? "") | \(data?.city_name ?? "")"
            lblAmount.text = "$\(data?.job_price ?? 0) | \(data?.client_user_name ?? "")"
           // lblPostDate.text = data?.job_post_created_on
        }
    }

}
