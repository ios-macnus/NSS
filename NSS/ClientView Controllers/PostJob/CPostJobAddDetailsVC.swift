//
//  CPostJobAddDetailsVC.swift
//  NSS
//
//  Created by Gowma on 21/03/21.
//

import UIKit
import Alamofire
import SwiftyJSON

class CPostJobAddDetailsVC: ParentVc {

    @IBOutlet weak var roundedView1: UIView!
    @IBOutlet weak var roundedView2: UIView!
    @IBOutlet weak var roundedView3: UIView!
    @IBOutlet weak var roundedView4: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view6: UIView!
    @IBOutlet weak var view7: UIView!
    
    @IBOutlet weak var txtJobTitle: UITextField!
    @IBOutlet weak var txtJobLocation: UITextField!
    @IBOutlet weak var txtCost: UITextField!
    @IBOutlet weak var txtJobOverview: UITextField!
    @IBOutlet weak var txtJobRequirement: UITextField!
    @IBOutlet weak var txtviewDesc: UITextView!
    @IBOutlet weak var txtJobQualification: UITextField!
    @IBOutlet weak var txtExpiryDate: UITextField!
    
    var jobIdB = ""
    let datePicker1 = UIDatePicker()
    var arrSecDashForB = [[String:AnyObject]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view1.layer.borderColor = UIColor.black.cgColor
        view1.layer.borderWidth = 0.6
        
        roundedView1.makeCircular()
        roundedView2.makeCircular()
        roundedView3.makeCircular()
        roundedView4.makeCircular()

        view2.layer.borderColor = UIColor.black.cgColor
        view2.layer.borderWidth = 0.6
        
        view3.layer.borderColor = UIColor.black.cgColor
        view3.layer.borderWidth = 0.6
        
        view4.layer.borderColor = UIColor.black.cgColor
        view4.layer.borderWidth = 0.6
        
        view5.layer.borderColor = UIColor.black.cgColor
        view5.layer.borderWidth = 0.6
        
        view6.layer.borderColor = UIColor.black.cgColor
        view6.layer.borderWidth = 0.6
        
        view7.layer.borderColor = UIColor.black.cgColor
        view7.layer.borderWidth = 0.6
        showDatePicker1()

    }
    
    func showDatePicker1() {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let calendar =  Calendar(identifier: .gregorian) //Calendar.current
        let currentDate = Date()
        var components = DateComponents()
        components.calendar = calendar
        
//        let modifiedDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)! //current date + 1
        components.year = +20
        let minDate = calendar.date(byAdding: components, to: currentDate)!
        
        datePicker1.minimumDate = minDate
        datePicker1.maximumDate = currentDate //maxDate
       // datePicker1.date = formatter.date(from:  "1990-01-01") ?? minDate
        datePicker1.datePickerMode = .date
       // txtDob.text = formatter.string(from: currentDate)
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker1));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        
        txtExpiryDate.inputAccessoryView = toolbar
        txtExpiryDate.inputView = datePicker1
        
    }
    
    @objc func donedatePicker1() {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        txtExpiryDate.text = formatter.string(from: datePicker1.date)
        
        self.view.endEditing(true)
    }

    @objc func cancelDatePicker() {
        self.view.endEditing(true)
    }
    
    @IBAction func btnBack(_ sender: Any) {
        dissmiss()
    }
    
    @IBAction func btnNext(_ sender: Any) {
        if txtJobTitle.text == "" {
            self.view.makeToast("Enter Job Title", duration: 3.0, position: .bottom)
        } else if txtJobLocation.text == "" {
            self.view.makeToast("Enter Job Location", duration: 3.0, position: .bottom)
        } else if txtCost.text == "" {
            self.view.makeToast("Enter Cost", duration: 3.0, position: .bottom)
        } else if txtJobOverview.text == "" {
            self.view.makeToast("Enter Job Overview", duration: 3.0, position: .bottom)
        }else if txtJobRequirement.text == "" {
            self.view.makeToast("Enter Job Requirement", duration: 3.0, position: .bottom)
        } else if txtJobQualification.text == "" {
            self.view.makeToast("Enter Job Qualification", duration: 3.0, position: .bottom)
        } else if txtExpiryDate.text == "" {
            self.view.makeToast("Enter Job Expiry Date", duration: 3.0, position: .bottom)
        } else {
            let storyBoard: UIStoryboard = UIStoryboard(name: "ClientPostJob", bundle: nil)
            let nextVC = storyBoard.instantiateViewController(withIdentifier: "CPostJobReviewVC") as! CPostJobReviewVC
            nextVC.modalPresentationStyle = .fullScreen
            nextVC.arrSecDashForB = arrSecDashForB
            nextVC.jobTitleB = txtJobTitle.text!
            nextVC.jobLocation = txtJobLocation.text!
            nextVC.jobCost = txtCost.text!
            nextVC.jobOverview = txtJobOverview.text!
            nextVC.jobRequirements = txtJobRequirement.text!
            nextVC.jobQualificationsB = txtJobQualification.text!
            nextVC.JobExpiryDate = txtExpiryDate.text!
            self.present(nextVC , animated: false, completion: nil)
        }
        
       
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
//MARK:- textfield delegate
@available(iOS 11.0, *)
extension CPostJobAddDetailsVC:UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if textField == txtJobTitle {
            let _ = txtJobLocation.becomeFirstResponder()
        } else if textField == txtJobLocation {
            let _ = txtCost.becomeFirstResponder()
        } else  if textField == txtCost {
            let _ = txtJobOverview.becomeFirstResponder()
        } else if textField == txtJobOverview {
            let _ = txtJobRequirement.becomeFirstResponder()
        } else if textField == txtJobRequirement {
            let _ = txtviewDesc.becomeFirstResponder()
        } else if textField == txtJobQualification {
            textField.resignFirstResponder()
        } else {
            self.view.endEditing(true)
        }
        return true
    }
    
}


