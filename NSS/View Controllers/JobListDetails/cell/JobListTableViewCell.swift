//
//  JobListTableViewCell.swift
//  NSS
//
//  Created by Gowma on 18/02/21.
//

import UIKit

class JobListTableViewCell: UITableViewCell {

    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblClientName: UILabel!
    @IBOutlet weak var lblClientRating: UILabel!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblPostDate: UILabel!
    @IBOutlet weak var imgFav: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
    }

    var data: jobListDataResponse? {
        didSet {
            lblTitle.text = data?.job_title
            lblClientName.text = data?.client_user_name
            lblClientRating.text = ""
            lblInfo.text = "\(data?.job_requirement ?? "") | \(data?.city_name ?? "")"
            lblAmount.text = "$\(data?.job_price ?? 0) | \(data?.client_user_name ?? "")"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            let date = dateFormatter.date(from: data?.job_post_created_on ?? "2021-01-01T00:00:00.000Z")
            dateFormatter.dateFormat = "dd MMM yyyy"
            lblPostDate.text = "\(dateFormatter.string(from: date!))"
            let is_favouriteT = data?.is_favourite
            if(is_favouriteT == true) {
                imgFav.image = UIImage.init(named: "heart_fill")
            } else {
                imgFav.image = UIImage.init(named: "Favourite")
            }
        }
    }
}

