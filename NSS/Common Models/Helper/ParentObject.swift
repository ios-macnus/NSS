//
//  ParentObject.swift
//  DeliverForMe
//
//  Created by Sowrirajan S on 18/07/20.
//  Copyright © 2020 optisol. All rights reserved.
//
import AVFoundation
// MARK:- Protocols
public protocol SPControls: class {
    var payLoad: [String: Any]? { get set}
    func alert(_ title: AlertTitle, _ message: String)
    func alert(_ title: AlertTitle, _ message: AlertMessage)
    func send(payLoad: [String: Any])
}

class ParentObject: NSObject {
    typealias completionHandler = (_ flag: Bool) -> Void
    weak var delegate: SPControls?
}

extension NSObject {
    public class var onlyClassName: String {
        return String(describing: self).components(separatedBy: ".").last ?? ""
    }
}
