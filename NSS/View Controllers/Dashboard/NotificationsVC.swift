//
//  NotificationsVC.swift
//  NSS
//
//  Created by Gowma on 05/02/21.
//

import UIKit

class NotificationsVC: ParentVc {

    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension NotificationsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "cell") as! NotificationsTableViewCell
        
        cell.selectionStyle = .none
        
        let normalText = "Kevin"
        let attrs = [NSAttributedString.Key.font : UIFont(name: "Avenir-Medium", size: 20)]
        let normalString = NSMutableAttributedString(string:normalText, attributes:attrs as [NSAttributedString.Key : UIFont?] as [NSAttributedString.Key : Any])
        normalString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 0.85, green: 0.65, blue: 0.13, alpha: 1.00), range: NSRange(location:0,length:normalText.count))
        
        let normalText1 = " Marked Project as complete "
        let attrs1 = [NSAttributedString.Key.font : UIFont(name: "Avenir", size: 17)]
        let normalString1 = NSMutableAttributedString(string:normalText1, attributes:attrs1 as [NSAttributedString.Key : UIFont?] as [NSAttributedString.Key : Any])
        normalString1.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: NSRange(location:0,length:normalText1.count))
        normalString.append(normalString1)
        cell.lblTitle.attributedText = normalString
        
        
        //        cell.viewBg.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.45).cgColor
        //         cell.viewBg.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        //         cell.viewBg.layer.shadowOpacity = 0.5
        //         cell.viewBg.layer.shadowRadius = 3.0
        //         cell.viewBg.layer.masksToBounds = false
        //         cell.viewBg.layer.cornerRadius = 2.0
        
       
        return cell
        
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        /*cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
         UIView.animate(withDuration: 0.3, animations: {
         cell.layer.transform = CATransform3DMakeScale(1.05,1.05,1)
         },completion: { finished in
         UIView.animate(withDuration: 0.1, animations: {
         cell.layer.transform = CATransform3DMakeScale(1,1,1)
         })
         })*/
        
        cell.alpha = 0
        cell.layer.transform = CATransform3DMakeScale(0.5, 0.5, 0.5)
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            cell.alpha = 1
            cell.layer.transform = CATransform3DScale(CATransform3DIdentity, 1, 1, 1)
        })
        
        
    }
}
