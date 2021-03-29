//
//  CSearchVC.swift
//  NSS
//
//  Created by Gowma on 15/03/21.
//

import UIKit

class ClientSearchVC: ParentVc {

    @IBOutlet weak var collView1: UICollectionView!
    @IBOutlet weak var collView2: UICollectionView!
    @IBOutlet weak var txtSearch: UITextField!
    
    var arrTitle = ["Movers","Cleaners","Aircon Service","Electrician","Handyman","Plumber"]
    var arrImage = ["imgs1","imgs2","imgs3","imgs4","imgs5","imgs6"]
    var arrpopularSearchTitle = ["Plumber","Electrician","Fan Fix","Move House","Leak Fix","Install"]
    
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

extension ClientSearchVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collView1 {
            return arrTitle.count
        }
        return arrpopularSearchTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collView1 {
            let cell = collView1.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CSearchHomeCollectionViewCell
            
            cell.lblTitle.text = arrTitle[indexPath.row]
            cell.imgUser.image = UIImage.init(named: arrImage[indexPath.row])
            
           /* cell.imgTitle.sd_setImage(with: NSURL(string: "\(imgT)") as URL?, placeholderImage:UIImage(named:"imgT4"))*/
            return cell
            
        }
        let cell = collView2.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CSearchPopularCollectionViewCell
        cell.viewBg.layer.borderColor = UIColor.black.cgColor
        cell.viewBg.layer.borderWidth = 1.5
        cell.lblTitle.text = arrpopularSearchTitle[indexPath.row]
        
       /* cell.imgTitle.sd_setImage(with: NSURL(string: "\(imgT)") as URL?, placeholderImage:UIImage(named:"imgT4"))*/
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        cell.alpha = 0
        cell.layer.transform = CATransform3DMakeScale(0.5, 0.5, 0.5)
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            cell.alpha = 1
            cell.layer.transform = CATransform3DScale(CATransform3DIdentity, 1, 1, 1)
        })
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        if collectionView == collView2 {
            //return CGSize(width: 240, height: 164)
            let width  = (collView2.frame.width-20)/3//(collView2.frame.width + 20)
            return CGSize(width: width, height: 30)
        }
        let width  = (collView1.frame.width-10)/2
        return CGSize(width: width, height: 150)
    }

}

// MARK: UITextFieldDelegate
extension ClientSearchVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)

        if(txtSearch.text == ""){
            self.view.makeToast("Enter Search text", duration: 3.0, position: .bottom)
        } else {
            let storyBoard: UIStoryboard = UIStoryboard(name: "ClientDashboard", bundle: nil)
            let nextVC = storyBoard.instantiateViewController(withIdentifier: "CSearchResultsListVC") as! CSearchResultsListVC
            nextVC.modalPresentationStyle = .fullScreen
            nextVC.searchStringB = txtSearch.text!
            self.present(nextVC , animated: false, completion: nil)
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
}
