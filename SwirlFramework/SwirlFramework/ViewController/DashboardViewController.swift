//
//  DashboardViewController.swift
//  AnalyticFramework
//
//  Created by Pinkesh Gajjar on 05/08/22.
//  Copyright © 2022 ProgrammingWithSwift. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import ObjectMapper
import SwiftyJSON

public class DashboardViewController: UIViewController {
    
    @IBOutlet weak var collectionViewLiveStream: UICollectionView!
    @IBOutlet weak var collectionViewPrevious: UICollectionView!
    
    @IBOutlet weak var viewUpcomingLabel: UIView!
    @IBOutlet weak var viewCCUpcomingLiveStream: UIView!
    @IBOutlet weak var viewUpcomingNotFound: UIView!
    @IBOutlet weak var lblUpcomingTitle: UILabel!
    @IBOutlet weak var lblUpcomingNotFound: UILabel!
    
    @IBOutlet weak var viewPreviousLabel: UIView!
    @IBOutlet weak var viewCCPreviousLiveStream: UIView!
    @IBOutlet weak var viewPreviousNotFound: UIView!
    @IBOutlet weak var lblPreviousTitle: UILabel!
    @IBOutlet weak var lblPreviousNotFound: UILabel!
    
    static var isAlreadyLaunchedOnce = false
    
    var arrayOfLiveStream = [LiveStream].init()
    var arrayOfCompletedLiveStream = [LiveStream].init()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpView()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setUpNavigation(animated: animated)
    }
    
    func setUpView() {
        
        if !DashboardViewController.isAlreadyLaunchedOnce {
            //FirebaseApp.configure()
            DashboardViewController.isAlreadyLaunchedOnce = true
        }
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.toolbarBarTintColor = .white
        IQKeyboardManager.shared.toolbarTintColor = UIColor.init(hex: "#323232")
        
        self.setCollectionView()
        self.setUpStackView()
        
        self.fetchLiveStreamData()
    }
    
    func fetchLiveStreamData() {
        
        
    }
    
    func setUpNavigation(animated: Bool) {
        
        if #available(iOS 15, *) {
                
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(hex: "#613FC0")
                
            let titleAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .bold), NSAttributedString.Key.foregroundColor: UIColor.white]
                appearance.titleTextAttributes = titleAttribute
                
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
            navigationController?.navigationBar.tintColor = UIColor.white
        } else {
            
            self.navigationController?.setNavigationBarHidden(false, animated: animated)
            self.navigationController?.navigationBar.barTintColor = UIColor.red
            UINavigationBar.appearance().barTintColor = UIColor.red
        }
    }
    
    func setCollectionView() {
        
        self.collectionViewLiveStream.delegate = self
        self.collectionViewLiveStream.dataSource = self
        
        self.collectionViewPrevious.delegate = self
        self.collectionViewPrevious.dataSource = self
    }
    
    func setUpStackView() {
        
        //self.viewCCPreviousLiveStream.isHidden = true
        self.viewUpcomingNotFound.isHidden = true
        self.viewPreviousNotFound.isHidden = true
    }
}

extension DashboardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.collectionViewLiveStream {
            return self.arrayOfLiveStream.count
        } else if collectionView == self.collectionViewPrevious {
            return self.arrayOfCompletedLiveStream.count
        } else {
            return 5
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.collectionViewLiveStream {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LiveStreamCollectionViewCell", for: indexPath) as! LiveStreamCollectionViewCell
            cell.tag = indexPath.row
            cell.delegate = self
            cell.btnSelectCell.tag = indexPath.row
            cell.objectOfLiveStream = self.arrayOfLiveStream[indexPath.row]
            cell.configCell()
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PreviousStreamCollectionViewCell", for: indexPath) as! PreviousStreamCollectionViewCell
            //cell.delegate = self
            cell.btnSelectCell.tag = indexPath.row
            cell.objectOfLiveStream = self.arrayOfCompletedLiveStream[indexPath.row]
            cell.configCell()
            return cell
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = CGFloat(Constants.deviceWidth / 2.8)
        let cellHieght = CGFloat(Constants.deviceWidth / 1.72)
        return CGSize.init(width: cellWidth, height: cellHieght)
    }
}

extension DashboardViewController: LiveStreamCCDelegate {
    
    func btnSelectCell(index: Int) {
        
        print("From btnSelectCell : ", index)
        let when = DispatchTime.now() + 0.1
        DispatchQueue.main.asyncAfter(deadline: when) {
            let loginResponse = ["userInfo": ["userID": index, "userName": "John"]]
            NotificationCenter.default
                        .post(name: NSNotification.Name("NotificationIdentifier"),
                         object: nil,
                         userInfo: loginResponse)
        }
    }
    
    func btnShareLink(index: Int) {
        
        let alert = UIAlertController(title: "Delete Live-Stream", message: "Are you sure want to delete this live-stream?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "YES", style: UIAlertAction.Style.destructive, handler: { action in
            
        }))
        alert.addAction(UIAlertAction(title: "NO", style: UIAlertAction.Style.destructive, handler: { action in

        }))
        self.present(alert, animated: true, completion: nil)
    }
}

