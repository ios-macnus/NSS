//
//  CFavActivitiesTableViewCell.swift
//  NSS
//
//  Created by Gowma on 15/03/21.
//

import UIKit

class CFavActivitiesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblClientName: UILabel!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblDateOfWork: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
