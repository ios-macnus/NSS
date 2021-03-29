//
//  CCurrentActivitiesTableViewCell.swift
//  NSS
//
//  Created by Gowma on 15/03/21.
//

import UIKit

class CCurrentActivitiesTableViewCell: UITableViewCell {

    @IBOutlet weak var viewBgBorder: UIView!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblClientName: UILabel!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblDateOfWork: UILabel!
    @IBOutlet weak var lblJobCompleteDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
