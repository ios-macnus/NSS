//
//  SearchHomeVC.swift
//  NSS
//
//  Created by Gowma on 05/02/21.
//

import UIKit

class SearchHomeVC: ParentVc {

    @IBOutlet weak var collView1: UICollectionView!
    @IBOutlet weak var collView2: UICollectionView!
    @IBOutlet weak var collView3: UICollectionView!
    @IBOutlet weak var searhView1: UIView!
    @IBOutlet weak var searhView3: UIView!

    @IBOutlet weak var collview1Height: NSLayoutConstraint!
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var closeBtn: UIButton!

    var arrTitle = ["Movers","Cleaners","Aircon Service","Electrician","Handyman","Plumber"]
    var arrImage = ["imgs1","imgs2","imgs3","imgs4","imgs5","imgs6"]
    
    var arrFilter = ["Driver","Packer","Mover"]

    var arrpopularSearchTitle = ["Plumber","Electrician","Fan Fix","Move House","Leak Fix","Install"]
    var arraySearchResultList:[String] = []
    var isFiltering: Bool = false
    var searchText: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searhView3.isHidden = true
        self.searhView1.isHidden = false
        self.collview1Height.constant = 306

        self.collView1.reloadData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.arraySearchResultList = self.arrFilter
    }
  
    @IBAction func closeBtn(_ sender: Any) {
        self.searchbar.text = ""
        self.searhView3.isHidden = true
               self.searhView1.isHidden = false
               self.collview1Height.constant = 306
               self.collView1.reloadData()
    }

}
extension SearchHomeVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collView1 {
            return arrTitle.count
        } else if collectionView == collView2 {
        return arrpopularSearchTitle.count
        } else if collectionView == collView3 {
            if isFiltering {
                       return self.arrFilter.count
            }
            return 0
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collView3 {
            if isFiltering {
                let cell = collView3.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SearchPopularCollectionViewCell
                           
                cell.viewBg.layer.backgroundColor = UIColor.lightGray.cgColor
                                  cell.lblTitle.text = arrFilter[indexPath.row]
                cell.lblTitle.textColor = UIColor.black
                          /* cell.imgTitle.sd_setImage(with: NSURL(string: "\(imgT)") as URL?, placeholderImage:UIImage(named:"imgT4"))*/
                           return cell
            }
        }
       else if collectionView == collView1 {
            
            let cell = collView1.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SearchHomeCollectionViewCell
            
            cell.lblTitle.text = arrTitle[indexPath.row]
            cell.imgUser.image = UIImage.init(named: arrImage[indexPath.row])
            
           /* cell.imgTitle.sd_setImage(with: NSURL(string: "\(imgT)") as URL?, placeholderImage:UIImage(named:"imgT4"))*/
            return cell
            
        }
        let cell = collView2.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SearchPopularCollectionViewCell

//        if isFiltering {
//                   return self.arraySearchResultList.count
//               }
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
            let width  = (collView2.frame.width + 20)
            return CGSize(width: width, height: 30)
        }else if collectionView == collView3 {
            //return CGSize(width: 240, height: 164)
            let width  = (collView3.frame.width + 20)
            return CGSize(width: width, height: 30)
        }
        let width  = (collView1.frame.width-10)/2
        return CGSize(width: width, height: 150)
    }

}


//MARK: - Search Delegate
extension SearchHomeVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
        if  self.searchbar.text!.count > 1 {
            self.isFiltering = true
            self.arraySearchResultList.removeAll()
            for i in 0 ..< self.arrFilter.count {
                let dic = self.arrFilter[i]
                let searchstr = self.searchbar.text!
                if dic.localizedCaseInsensitiveContains(searchstr)  {
                    self.arraySearchResultList.append(dic)
                }
            }
        } else {
            self.isFiltering = false
        }
        self.searhView1.isHidden = true
        self.collview1Height.constant = 0
        self.searhView3.isHidden = false
        self.view.bringSubviewToFront(self.searhView3)
        self.collView3.reloadData()
       

    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Searching...")
    }
}

