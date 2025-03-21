//
//  Utils.swift
//  SevenAppsCase
//
//  Created by Oguz Yildirim on 21.03.2025.
//

import Foundation
import UIKit

final class Utils: NSObject {
    static let instance = Utils()

    func shareSheet(vc: UIViewController, url: String) {
        let myWebsite = URL(string: url)!
        let shareAll = [myWebsite] as [Any]
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = vc.view
        activityViewController.popoverPresentationController?.sourceRect = vc.view.frame

        vc.present(activityViewController, animated: true, completion: nil)
    }
}
