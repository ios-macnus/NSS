//
//  PastActivitiesTableViewCell.swift
//  NSS
//
//  Created by Gowma on 19/02/21.
//

import UIKit

class PastActivitiesTableViewCell: UITableViewCell {
    @IBOutlet weak var viewBgBorder: UIView!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblClientName: UILabel!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblDateOfWork: UILabel!
    @IBOutlet weak var lblJobCompleteDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewBgBorder.layer.borderColor = UIColor.black.cgColor
        viewBgBorder.layer.borderWidth = 1.0
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
