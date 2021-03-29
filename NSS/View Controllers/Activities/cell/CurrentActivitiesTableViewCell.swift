//
//  CurrentActivitiesTableViewCell.swift
//  NSS
//
//  Created by Gowma on 05/02/21.
//

import UIKit

class CurrentActivitiesTableViewCell: UITableViewCell {

    @IBOutlet weak var viewBgDate: UIView!
    @IBOutlet weak var viewBgBorder: UIView!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblClientName: UILabel!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblAppliedDate: UILabel!
    @IBOutlet weak var lblShortlistDate: UILabel!
    @IBOutlet weak var lblOfferedDate: UILabel!
    @IBOutlet weak var lblAcceptedDate: UILabel!
    @IBOutlet weak var lblStartDate: UILabel!
    @IBOutlet weak var lblEndDate: UILabel!
    @IBOutlet weak var lblJobCompleteDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewBgBorder.layer.borderColor = UIColor.black.cgColor
        viewBgBorder.layer.borderWidth = 1.0
        viewBgDate.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.45).cgColor
        viewBgDate.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewBgDate.layer.shadowOpacity = 0.5
        viewBgDate.layer.shadowRadius = 3.0
        viewBgDate.layer.masksToBounds = false
        viewBgDate.layer.cornerRadius = 2.0
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
            lblAmount.text = "Job Price $\(data?.job_price ?? 0) | \(data?.client_user_name ?? "")"
           // lblPostDate.text = data?.job_post_created_on
        }
    }
    
}
