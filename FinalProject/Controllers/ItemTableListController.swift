//
//  ItemListController.swift
//  FinalProject
//
//  Created by kien on 8/6/18.
//  Copyright © 2018 kien. All rights reserved.
//

import UIKit

class ItemTableListController: UIViewController {

    // MARK: - Outlet
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    var listAnime = [ItemModel]()
    var category : String?
    var type: String?
    let objProgressView = ProgressView()
    var loadingData = false
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        if !loadingData {
            loadData(page: page)
            page += 1
        }
        // Do any additional setup after loading the view.
    }
    
    func loadData(page: Int){
        loadingData = true
        if let ca = category, let ty =  type{
            objProgressView.show()
            NetWorkManager.shared.get(type: ty, page: page, category: ca) { (list) in
                if let list = list{
                    self.listAnime = self.listAnime + list
                    DispatchQueue.main.sync {
                        self.tableView.reloadData()
                        self.objProgressView.hide()
                        self.loadingData = false
                    }
                }
                else{
                    self.objProgressView.hide()
                    self.loadingData = false
                }
            }
        }
    }
    
    
    func setUpTableView(){
        tableView.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "TableListViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        
    }

}
extension ItemTableListController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listAnime.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableListViewCell") as? ItemTableViewCell else {
            return UITableViewCell()
        }
        cell.set(item: listAnime[indexPath.row])
        return cell
    }
}
extension ItemTableListController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let ty = type{
            if ty == "anime"{
                guard let controller = storyboard.instantiateViewController(withIdentifier: "DetailAnimeController") as? DetailAnimeController else {
                    return
                }
                controller.item = listAnime[indexPath.row]
                present(controller, animated: true, completion: nil)
            }
            else{
                guard let controller = storyboard.instantiateViewController(withIdentifier: "DetailMangaController") as? DetailMangaController else {
                    return
                }
                controller.item = listAnime[indexPath.row]
                present(controller, animated: true, completion: nil)
            }
        }
        
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = listAnime.count - 1
        if !loadingData && indexPath.row == lastElement {
            loadData(page: page)
        }
    }
}
