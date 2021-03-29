//
//  SkillsSelectionVC.swift
//  NSS
//
//  Created by Gowma on 24/01/21.
//

import UIKit


class SkillsSelectionVC: ParentVc, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collView: UICollectionView!
    var viewModel = commonDataViewModel()
    var strUserId = ""
    override var payLoad: [String : Any]? {
        didSet {
            if let titleB = payLoad?["userId"] as? String {
                self.strUserId = titleB
            }
        }
    }
    
    var arrSecDashFor = [[String:AnyObject]]() //Array of dictionary
    var selId : [Int] = []
    var selIndex : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchCommonData()
    }
    
    func fetchCommonData() {
        
        
        showOnViewTwins()
        
        viewModel.fetchCommonData(commonDataRequestModel) { [weak self] (flag) in
            if flag {
                //print("-----")
                //print(self?.viewModel.bannerResponse?.gender ?? "")
                self?.collView.reloadData()
                 self?.hideLoadingHub()
                
            }
        }
    }
    
    var commonDataRequestModel: [String: Any] {
        return [
            //"UserType": "Parent",
            "country_Residence": "IN",
            //"Email": UserDefaults().get(key: .email) as Any
        ]
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }

    @IBAction func btnRegister(_ sender: Any) {
        if selIndex.count >= 3 {
            self.goToPresent(self, storyBoard: .main, id: .registerSuccessVC, payLoad: payLoad)
        } else {
            self.view.makeToast("Choose Minimum 3 Skills", duration: 3.0, position: .bottom)
        }
        

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.bannerResponse?.skills?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SkilsCollectionViewCell
                
        
        
        
        cell.lblTitle.text =  self.viewModel.bannerResponse?.skills?[indexPath.row].skill
        if selIndex.contains("\(indexPath.row)") {
            cell.viewBg.layer.borderColor = UIColor(red: 0.85, green: 0.65, blue: 0.13, alpha: 1.00).cgColor
            cell.viewBg.layer.borderWidth = 1
        } else {
            cell.viewBg.layer.borderColor = UIColor.darkGray.cgColor
            cell.viewBg.layer.borderWidth = 1
        }

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
        // handle tap events
        if selIndex.contains("\(indexPath.row)") {
            if let index = selIndex.firstIndex(of: "\(indexPath.row)") {
                selIndex.remove(at: index)
                selId.remove(at: index)
            }
            
        } else {
                selIndex.append("\(indexPath.row)")
                selId.append(self.viewModel.bannerResponse?.skills?[indexPath.row].skill_id ?? 0)
            
        }
        
        self.collView.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width  = (collView.frame.width-10)/2
        return CGSize(width: width, height: 40)
    }
}
