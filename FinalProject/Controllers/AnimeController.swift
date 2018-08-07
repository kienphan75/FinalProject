//
//  ListAnimeController.swift
//  FinalProject
//
//  Created by kien on 8/6/18.
//  Copyright © 2018 kien. All rights reserved.
//

import UIKit
import BmoViewPager

class AnimeController: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var pageNavigation: BmoViewPagerNavigationBar!
    @IBOutlet weak var viewPage: BmoViewPager!
    
    // MARK: - Variables
    var arrCategory = ["Upcoming","Movie","Special"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewPage.dataSource = self
        viewPage.isHidden = false
        pageNavigation.autoFocus = false
        pageNavigation.backgroundColor = UIColor(hexString: "#F83F1B")
        pageNavigation.viewPager = viewPage

    }
}
extension AnimeController: BmoViewPagerDataSource{
    
    func bmoViewPagerDataSourceNumberOfPage(in viewPager: BmoViewPager) -> Int {
        return arrCategory.count
    }
    func bmoViewPagerDataSource(_ viewPager: BmoViewPager, viewControllerForPageAt page: Int) -> UIViewController {
        let storyboad = UIStoryboard(name: "Main", bundle: nil)
        guard let tableController = storyboad.instantiateViewController(withIdentifier: "ItemTableListController") as? ItemTableListController else{
            return UIViewController()
        }
        tableController.type = "anime"
        tableController.category = arrCategory[page].lowercased()
        return tableController
    }
    func bmoViewPagerDataSourceNaviagtionBarItemSize(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> CGSize {
        var num = 1
        if arrCategory.count > 0{
             num = arrCategory.count
        }
        return CGSize(width: (navigationBar.bounds.width / CGFloat(num)), height: navigationBar.bounds.height)
    }
    func bmoViewPagerDataSourceNaviagtionBarItemTitle(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> String? {
        return arrCategory[page]
    }
    func bmoViewPagerDataSourceNaviagtionBarItemHighlightedBackgroundView(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> UIView? {
        let mView = UnderLineView()
        mView.strokeColor = UIColor.white
        return mView
    }
    func bmoViewPagerDataSourceNaviagtionBarItemHighlightedAttributed(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> [NSAttributedStringKey : Any]? {
        return [
            NSAttributedStringKey.foregroundColor : UIColor.white,
            NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 14)
        ]
    }
    
    
    func bmoViewPagerDataSourceNaviagtionBarItemNormalAttributed(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> [NSAttributedStringKey : Any]? {
        return [
            NSAttributedStringKey.foregroundColor : UIColor(hexString: "#E0E0E0"),
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)]
    }
    
}
