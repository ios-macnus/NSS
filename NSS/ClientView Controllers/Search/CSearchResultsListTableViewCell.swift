//
//  CSearchResultsListTableViewCell.swift
//  NSS
//
//  Created by Gowthaman Anandakumar on 29/03/21.
//

import UIKit

class CSearchResultsListTableViewCell: UITableViewCell {

    @IBOutlet weak var viewBgBorder: UIView!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblClientName: UILabel!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var lblAmount: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
