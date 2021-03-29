//
//  JobListDataViewModel.swift
//  NSS
//
//  Created by Gowma on 19/02/21.
//

import UIKit
import Alamofire

class JobListDataViewModel: ParentObject {
    var jobListData: [jobListDataResponse]?

    var urlFetch = APIConstants.fetchUrl(.freelancer_allJobs)
    
    var numberOfRows: Int {
        return jobListData?.count ?? 0
    }
    func getJobList(index: Int) -> jobListDataResponse? {
        return jobListData?.safe(at: index) ?? nil
    }
    
    //MARK:- SERVICE CALL
    func jobListDataFetch(_ payload: [String: Any],
                          completion: @escaping completionHandler) {
        let url = APIConstants.fetchUrl(.freelancer_allJobs)
        ServiceWorker.set(url: urlFetch, payload: payload, false, false, closure: { [weak self] (response: JobListDataModel) in
            if response.success == true {
                self?.jobListData = response.data
                completion(true)
            } else {
                self?.delegate?.alert(.alertError, response.message ?? unpredictedError)
                completion(false)
            }
        }) { (error: AFError) in
            self.delegate?.alert(.alertError, error.localizedDescription)
            completion(false)
        }
    }
}

class JobListDataViewModel1: ParentObject {
    var jobListData1: [jobListDataResponse]?
    
    var numberOfRows1: Int {
        return jobListData1?.count ?? 0
    }
    func getJobList1(index: Int) -> jobListDataResponse? {
        return jobListData1?.safe(at: index) ?? nil
    }
    
    //MARK:- SERVICE CALL
    func jobListDataFetch(_ payload: [String: Any],
                          completion: @escaping completionHandler) {
        let url = APIConstants.fetchUrl(.freelancer_recommended_jobsApi)
        ServiceWorker.set(url: url, payload: payload, false, false, closure: { [weak self] (response: JobListDataModel) in
            if response.success == true {
                self?.jobListData1 = response.data
                completion(true)
            } else {
                self?.delegate?.alert(.alertError, response.message ?? unpredictedError)
                completion(false)
            }
        }) { (error: AFError) in
            self.delegate?.alert(.alertError, error.localizedDescription)
            completion(false)
        }
    }
}

class JobListDataViewModel2: ParentObject {
    var jobListData2: [jobListDataResponse]?
    
    var numberOfRows2: Int {
        return jobListData2?.count ?? 0
    }
    func getJobList2(index: Int) -> jobListDataResponse? {
        return jobListData2?.safe(at: index) ?? nil
    }
    
    //MARK:- SERVICE CALL
    func jobListDataFetch(_ payload: [String: Any],
                          completion: @escaping completionHandler) {
        let url = APIConstants.fetchUrl(.freelancer_trending_jobsApi)
        ServiceWorker.set(url: url, payload: payload, false, false, closure: { [weak self] (response: JobListDataModel) in
            if response.success == true {
                self?.jobListData2 = response.data
                completion(true)
            } else {
                self?.delegate?.alert(.alertError, response.message ?? unpredictedError)
                completion(false)
            }
        }) { (error: AFError) in
            self.delegate?.alert(.alertError, error.localizedDescription)
            completion(false)
        }
    }
}

class JobListDataViewModel3: ParentObject {
    var jobListData3: [jobListDataResponse]?
    
    var numberOfRows3: Int {
        return jobListData3?.count ?? 0
    }
    func getJobList3(index: Int) -> jobListDataResponse? {
        return jobListData3?.safe(at: index) ?? nil
    }
    
    //MARK:- SERVICE CALL
    func jobListDataFetch(_ payload: [String: Any],
                          completion: @escaping completionHandler) {
        let url = APIConstants.fetchUrl(.freelancer_nearby_jobsApi)
        ServiceWorker.set(url: url, payload: payload, false, false, closure: { [weak self] (response: JobListDataModel) in
            if response.success == true {
                self?.jobListData3 = response.data
                completion(true)
            } else {
                self?.delegate?.alert(.alertError, response.message ?? unpredictedError)
                completion(false)
            }
        }) { (error: AFError) in
            self.delegate?.alert(.alertError, error.localizedDescription)
            completion(false)
        }
    }
}

class JobListDataViewModel4: ParentObject {
    var jobListData4: [jobListDataResponse]?
    
    var numberOfRows4: Int {
        return jobListData4?.count ?? 0
    }
    func getJobList4(index: Int) -> jobListDataResponse? {
        return jobListData4?.safe(at: index) ?? nil
    }
    
    //MARK:- SERVICE CALL
    func jobListDataFetch(_ payload: [String: Any],
                          completion: @escaping completionHandler) {
        let url = APIConstants.fetchUrl(.freelancer_recent_jobsApi)
        ServiceWorker.set(url: url, payload: payload, false, false, closure: { [weak self] (response: JobListDataModel) in
            if response.success == true {
                self?.jobListData4 = response.data
                completion(true)
            } else {
                self?.delegate?.alert(.alertError, response.message ?? unpredictedError)
                completion(false)
            }
        }) { (error: AFError) in
            self.delegate?.alert(.alertError, error.localizedDescription)
            completion(false)
        }
    }
}
