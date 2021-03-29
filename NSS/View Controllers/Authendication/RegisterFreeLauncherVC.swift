//
//  RegisterFreeLauncherVC.swift
//  NSS
//
//  Created by Gowma on 24/01/21.
//

import UIKit
import Alamofire
import SwiftyJSON

class RegisterFreeLauncherVC: ParentVc {
    @IBOutlet weak var viewTxt1Bg: UIView!
    @IBOutlet weak var viewTxt2Bg: UIView!
    @IBOutlet weak var viewTxt3Bg: UIView!
    @IBOutlet weak var viewTxt4Bg: UIView!
    @IBOutlet weak var viewTxt5Bg: UIView!
    @IBOutlet weak var viewTxt6Bg: UIView!
    @IBOutlet weak var viewTxt7Bg: UIView!
    @IBOutlet weak var viewTxt8Bg: UIView!
    @IBOutlet weak var viewTxt9Bg: UIView!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    @IBOutlet weak var txtState: UITextField!
    @IBOutlet weak var txtGender: UITextField!
    @IBOutlet weak var txtDob: UITextField!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var dropdownCountry: DropDown!
    @IBOutlet weak var dropdownState: DropDown!
    @IBOutlet weak var dropdownGender: DropDown!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgEye: UIImageView!
    
    private var pwdShow = false
    var viewModel = commonDataViewModel()
    
    let datePicker1 = UIDatePicker()
    var arrList1:[String] = []
    var arrListId1:[Int] = []
    
    var arrList2:[String] = []
    var arrListId2:[Int] = []

    var arrList3:[String] = []
    var arrListId3:[Int] = []

    var arrList5:[String] = ["Yes", "No"]
    var arrListId5:[Int] = [1,2]
    var selCountryId = ""
    var selStateId = ""
    var selGenderId = ""
    var userType = "2"
    var userIdN = ""
    var str1 = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        viewTxt1Bg.layer.borderWidth = 1.0
        viewTxt1Bg.layer.borderColor = UIColor.black.cgColor
        viewTxt2Bg.layer.borderWidth = 1.0
        viewTxt2Bg.layer.borderColor = UIColor.black.cgColor
        viewTxt3Bg.layer.borderWidth = 1.0
        viewTxt3Bg.layer.borderColor = UIColor.black.cgColor
        viewTxt4Bg.layer.borderWidth = 1.0
        viewTxt4Bg.layer.borderColor = UIColor.black.cgColor
        viewTxt5Bg.layer.borderWidth = 1.0
        viewTxt5Bg.layer.borderColor = UIColor.black.cgColor
        viewTxt6Bg.layer.borderWidth = 1.0
        viewTxt6Bg.layer.borderColor = UIColor.black.cgColor
        viewTxt7Bg.layer.borderWidth = 1.0
        viewTxt7Bg.layer.borderColor = UIColor.black.cgColor
        viewTxt8Bg.layer.borderWidth = 1.0
        viewTxt8Bg.layer.borderColor = UIColor.black.cgColor
        viewTxt9Bg.layer.borderWidth = 1.0
        viewTxt9Bg.layer.borderColor = UIColor.black.cgColor
        txtFirstName.becomeFirstResponder()

        if(userType == "2") {
            lblTitle.text = "Sign Up as Freelancer"
        } else {
            lblTitle.text = "Sign Up as Client"
        }
        // Do any additional setup after loading the view.
        fetchCommonData()
        showDatePicker1()
        setListDropdown1()
        setListDropdown2()
        setListDropdown3()
    }
    
    func fetchCommonData() {
        
        
        viewModel.fetchCommonData(commonDataRequestModel) { [weak self] (flag) in
            if flag {
                //print("-----")
                //print(self?.viewModel.bannerResponse?.gender ?? "")
                let genderListT = self?.viewModel.bannerResponse?.gender
                let genderCountT = genderListT?.count ?? 0
                for i in 0..<genderCountT {
                    //arrSelAmount.add(arrtempAmountT![i])
                    let n = genderListT?[i]
                    let valT = n?.gender
                    let IdT = n?.gender_id
                    self?.arrList3.append(valT ?? "")
                    self?.arrListId3.append(IdT ?? 0)
                    
                }
                self?.setListDropdown3()
                self?.getCountryList()
            }
        }
    }
   
    func getCountryList() {
                  
        let url = APIConstants.fetchUrl(.country_listApi)
          AF.request(url,method:.get, parameters: nil , encoding:  JSONEncoding.default, headers: nil).responseJSON {(responseData) -> Void in
              
              switch responseData.result {
              case .success(let value):
                  let swiftyJsonVar = JSON(value)
                  print(swiftyJsonVar)
                  if let resData = swiftyJsonVar[].dictionaryObject {
                      let status = (resData)["status"] as! Bool
                      let message = (resData)["message"] as! String
                      if status {
                         let arrListT = (resData)["data"] as! NSArray
                        for i in 0..<arrListT.count {
                            //arrSelAmount.add(arrtempAmountT![i])
                             let n = arrListT[i] as! NSDictionary
                             let titleT = n["country_name"]!
                            let idT = n["country_id"] as! Int
                            self.arrList1.append("\(titleT)")
                            self.arrListId1.append(idT)
                            self.setListDropdown1()
                        }
                        self.selCountryId = "\(self.arrListId1[0])"
                        self.getStateList()

                      } else {
                        
                          self.view.makeToast("\(message)", duration: 3.0, position: .bottom)
                      }
                  }
              case .failure(let error):
                  print(error)
                  //ANLoader.hide()
              }
          }
    }

    func getStateList() {
        self.arrList2.removeAll()
        self.arrListId2.removeAll()
        
          AF.request("http://sampleapp-env.eba-xbpbgrv3.ap-southeast-2.elasticbeanstalk.com/api/public/state/\(self.selCountryId)",method:.get, parameters: nil , encoding:  JSONEncoding.default, headers: nil).responseJSON {(responseData) -> Void in
              
              switch responseData.result {
              case .success(let value):
                  let swiftyJsonVar = JSON(value)
                  print(swiftyJsonVar)
                  if let resData = swiftyJsonVar[].dictionaryObject {
                      let status = (resData)["status"] as! Bool
                      let message = (resData)["message"] as! String
                      if status {
                         let arrListT = (resData)["data"] as! NSArray
                        for i in 0..<arrListT.count {
                            //arrSelAmount.add(arrtempAmountT![i])
                             let n = arrListT[i] as! NSDictionary
                             let titleT = n["state_name"]!
                            let idT = n["state_id"] as! Int
                            self.arrList2.append("\(titleT)")
                            self.arrListId2.append(idT)
                            self.setListDropdown2()
                        }

                      } else {
                        
                          self.view.makeToast("\(message)", duration: 3.0, position: .bottom)
                      }
                  }
              case .failure(let error):
                  print(error)
                  //ANLoader.hide()
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
    
    func showDatePicker1() {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let calendar =  Calendar(identifier: .gregorian) //Calendar.current
        let currentDate = Date()
        var components = DateComponents()
        components.calendar = calendar
        
//        let modifiedDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)! //current date + 1
        components.year = -50
        let minDate = calendar.date(byAdding: components, to: currentDate)!
        
        datePicker1.minimumDate = minDate
        datePicker1.maximumDate = currentDate //maxDate
        datePicker1.date = formatter.date(from:  "1990-01-01") ?? minDate
        datePicker1.datePickerMode = .date
       // txtDob.text = formatter.string(from: currentDate)
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker1));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        
        txtDob.inputAccessoryView = toolbar
        txtDob.inputView = datePicker1
        
    }
    
    @objc func donedatePicker1() {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        txtDob.text = formatter.string(from: datePicker1.date)
        
        self.view.endEditing(true)
    }

    @objc func cancelDatePicker() {
        self.view.endEditing(true)
    }
    
    func setListDropdown1() {
        
        dropdownCountry.optionArray = self.arrList1
        dropdownCountry.optionIds =  self.arrListId1
        dropdownCountry.didSelect{(selectedText , index, id ) in
            self.txtCountry.text = selectedText
            self.selCountryId = "\(self.arrListId1[index])"
            self.getStateList()
            self.txtMobile.text = ""
            //self.selVehicleId = "\(self.arrVehicleListId[index])"
        }
        dropdownCountry.textAlignment = .center
        dropdownCountry.arrowSize = 15
        dropdownCountry.arrowColor = UIColor(red: 0.85, green: 0.65, blue: 0.13, alpha: 1.00)
        dropdownCountry.rowHeight = 50
        dropdownCountry.listHeight = 50 * 4
        dropdownCountry.rowBackgroundColor = UIColor.white
        dropdownCountry.selectedRowColor = UIColor.lightGray
        dropdownCountry.isSearchEnable = false
    }

    func setListDropdown2() {
        
        dropdownState.optionArray = self.arrList2
        dropdownState.optionIds =  self.arrListId2
        dropdownState.didSelect{(selectedText , index, id ) in
            self.txtState.text = selectedText
            self.selStateId = "\(self.arrListId2[index])"
            //self.selVehicleId = "\(self.arrVehicleListId[index])"
        }
        dropdownState.textAlignment = .center
        dropdownState.arrowSize = 15
        dropdownState.arrowColor = UIColor(red: 0.85, green: 0.65, blue: 0.13, alpha: 1.00)
        dropdownState.rowHeight = 50
        dropdownState.listHeight = 50 * 4
        dropdownState.rowBackgroundColor = UIColor.white
        dropdownState.selectedRowColor = UIColor.lightGray
        dropdownState.isSearchEnable = false
    }


    func setListDropdown3() {
        
        dropdownGender.optionArray = self.arrList3
        dropdownGender.optionIds =  self.arrListId3
        dropdownGender.didSelect{(selectedText , index, id ) in
            self.txtGender.text = selectedText
            self.selGenderId = "\(self.arrListId3[index])"
            //self.selVehicleId = "\(self.arrVehicleListId[index])"
        }
        dropdownGender.textAlignment = .center
        dropdownGender.arrowSize = 15
        dropdownGender.arrowColor = UIColor(red: 0.85, green: 0.65, blue: 0.13, alpha: 1.00)
        dropdownGender.rowHeight = 50
        dropdownGender.listHeight = 50 * 4
        dropdownGender.rowBackgroundColor = UIColor.white
        dropdownGender.selectedRowColor = UIColor.lightGray
        dropdownGender.isSearchEnable = false
    }

    
    @IBAction func btnShowPwd(_ sender: Any) {
        if pwdShow {
            imgEye.image = UIImage.init(named: "eye-off")
            txtPassword.isSecureTextEntry = true
            pwdShow = false

        } else {
            imgEye.image = UIImage.init(named: "eye")
            pwdShow = true
            txtPassword.isSecureTextEntry = false
        }
    }
    
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func btnSubmit(_ sender: Any) {
        //self.goToPresent(self, storyBoard: .main, id: .skillsSelectionVC, payLoad: payLoad)
        self.view.endEditing(true)
        if(txtFirstName.text == ""){
            self.view.makeToast("Enter firstname", duration: 3.0, position: .bottom)
        }else if(txtLastName.text == ""){
            self.view.makeToast("Enter lastname", duration: 3.0, position: .bottom)
        }else if(txtEmail.text == ""){
            self.view.makeToast("Enter email", duration: 3.0, position: .bottom)
        }else if !isValidEmail(txtEmail.text!){
            self.view.makeToast("Enter valid email", duration: 3.0, position: .bottom)
        }else if(txtPassword.text == ""){
            self.view.makeToast("Enter your password", duration: 3.0, position: .bottom)
        }else if(txtPassword.text!.count < 8){
            self.view.makeToast("Password length minimum 8 characters", duration: 3.0, position: .bottom)
        }else if(txtCountry.text == ""){
            self.view.makeToast("Select Country", duration: 3.0, position: .bottom)
        }else if(txtState.text == ""){
            self.view.makeToast("Select State", duration: 3.0, position: .bottom)
        }else if(txtGender.text == ""){
            self.view.makeToast("Select Gender", duration: 3.0, position: .bottom)
        }else if(txtMobile.text == ""){
            self.view.makeToast("Enter your mobile number", duration: 3.0, position: .bottom)
        }else {
            
            SubmitRegister()
        }
    }

    func SubmitRegister() {
         
         //ANLoader.showLoading("Loading", disableUI: false)
         //ANLoader.activityBackgroundColor = UIColor(red: 0.32, green: 0.71, blue: 0.45, alpha: 1.00)
        let str11 = txtMobile.text?.removeWhitespace()

         
        let param: [String: Any] = ["firstName" : txtFirstName.text! ,"lastName" : txtLastName.text! ,"email" : txtEmail.text! , "password" : txtPassword.text!, "dob" : txtDob.text!, "gender_id" : selGenderId, "county_id" : selCountryId, "state_id" : selStateId, "city_id" : "13","mobile_no": str11!]
         
         //"\(demourl)dashboard.php"
         AF.request("http://sampleapp-env.eba-xbpbgrv3.ap-southeast-2.elasticbeanstalk.com/api/auth/register/\(self.userType)",method:.post, parameters: param , encoding:  JSONEncoding.default, headers: nil).responseJSON {(responseData) -> Void in
             
             switch responseData.result {
             case .success(let value):
                print(JSON(value))
                 let swiftyJsonVar = JSON(value)
                 print(swiftyJsonVar)
                 if let resData = swiftyJsonVar[].dictionaryObject {
                     let message = (resData)["message"] as! String
                    if message  ==  "Validation error: \"mobile_no\" must be a number" {
                        self.view.makeToast("Mobile number not in the correct format", duration: 1.0, position: .bottom)
                    } else {
                    let status = (resData)["status"] as! Bool

                     if status {
                        let nT = (resData)["user_id"] as! Int
                        self.userIdN = "\(nT)"
                        
//                         let dictT = (resData)["user_details"] as! NSDictionary
//                         let userIdT = dictT["user_id"]!
//                         let emailT = dictT["email"]!
//                         let nameT = dictT["name"]!
//                         let phone_numberT = dictT["phone_number"]!
//                         let tokenT = dictT["token"]!
//
//                         UserDefaults.standard.set("\(userIdT)", forKey: "user_id")
//                         UserDefaults.standard.set("\(nameT)", forKey: "user_name")
//                         UserDefaults.standard.set("\(emailT)", forKey: "user_email")
//                         UserDefaults.standard.set("\(phone_numberT)", forKey: "user_phone")
//                         UserDefaults.standard.set("\(tokenT)", forKey: "access_token")
//                         UserDefaults.standard.synchronize()
//
                         self.view.makeToast("\(message)", duration: 1.0, position: .bottom)
                         Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.runTimedCode1), userInfo: nil, repeats: false)
                         
                     }else{
                         self.view.makeToast("\(message)", duration: 1.0, position: .bottom)
                     }
                    }

                     //ANLoader.hide()
                 }
             case .failure(let error):
                 print(error)
                 //ANLoader.hide()
             }
             
           
         }
     }
     
      @objc func runTimedCode1() {
        if(userType == "2") {
            payLoad = ["userId": self.userIdN]
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nextVC = storyBoard.instantiateViewController(withIdentifier: "SkillsSelectionVC") as! SkillsSelectionVC
            nextVC.modalPresentationStyle = .fullScreen
            nextVC.payLoad = payLoad
            self.present(nextVC , animated: false, completion: nil)
        } else {
            self.goToPresent(self, storyBoard: .main, id: .loginSegVC)
        }
        
        //self.goToPresent(self, storyBoard: .main, id: .skillsSelectionVC, payLoad: payLoad)
        
        
     }

    
}
// MARK: UITextFieldDelegate
extension RegisterFreeLauncherVC: UITextFieldDelegate {
    
   
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtFirstName {
            txtFirstName.resignFirstResponder()
            txtLastName.becomeFirstResponder()
        } else if textField == txtLastName {
            txtLastName.resignFirstResponder()
            txtEmail.becomeFirstResponder()
        } else if textField == txtEmail {
            txtEmail.resignFirstResponder()
            txtPassword.becomeFirstResponder()
        } else if textField == txtPassword {
            txtPassword.resignFirstResponder()
        } else {
            self.view.endEditing(true)
        }
        
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

           if(textField == txtMobile){
               guard let text = textField.text else { return false }
                  let newString = (text as NSString).replacingCharacters(in: range, with: string)
            if txtCountry.text == "New Zealand" {
                  textField.text = format(with: "+XX XX XX XXXX", phone: newString)
                } else if self.txtCountry.text == "Australia" {
                textField.text = format(with: "+XX XXX XXX XXX", phone: newString)
            }
            return false
               }
           
           return true
       }
     func format(with mask: String, phone: String) -> String {
         let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
         var result = ""
         var index = numbers.startIndex // numbers iterator

         // iterate over the mask characters until the iterator of numbers ends
         for ch in mask where index < numbers.endIndex {
             if ch == "X" {
                 // mask requires a number in this place, so take the next one
                 result.append(numbers[index])

                 // move numbers iterator to the next index
                 index = numbers.index(after: index)

             } else {
                 result.append(ch) // just append a mask character
             }
         }
         return result
     }
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
}
extension String {
    var isPhoneNumber: Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSRange(location: 0, length: self.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count
            } else {
                return false
            }
        } catch {
            return false
        }
    }
}
extension String {
   func replace(string:String, replacement:String) -> String {
       return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
   }

   func removeWhitespace() -> String {
       return self.replace(string: " ", replacement: "")
   }
 }
