//
//  DetailAnimeController.swift
//  FinalProject
//
//  Created by kien on 8/6/18.
//  Copyright © 2018 kien. All rights reserved.
//

import UIKit

class DetailAnimeController: UIViewController {

    @IBOutlet weak var lbTitleNavigation: UILabel!
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var viewDes: UIStackView!
    @IBOutlet weak var viewJTitle: UIStackView!
    @IBOutlet weak var viewEtitle: UIStackView!
    @IBOutlet weak var viewTitle: UIStackView!
    @IBOutlet weak var imgImage: UIImageView!
    @IBOutlet weak var lbDuration: UILabel!
    @IBOutlet weak var lbRate: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbEnglishTitle: UILabel!
    @IBOutlet weak var lbJapanTitle: UILabel!
    @IBOutlet weak var lbDes: UILabel!
    
    @IBAction func actionClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    // MARK: - Variables
    var anime : AnimeModel?
    var item: ItemModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewContent.isHidden = true
        if let title = item?.title{
            self.lbTitleNavigation.text = title
        }
        else{
            self.lbTitleNavigation.text = ""
        }
        if let ID = item?.mal_id{
            print("ID: ",ID)
            NetWorkManager.shared.getDetailAnime(id: ID, page: 1) { (anime) in
                if let a = anime{
                    self.anime = a
                    DispatchQueue.main.async {
                        if let _ = self.anime?.error {
                            let alert = UIAlertController(title: "Error", message: "\nPlease try again!", preferredStyle: .alert)
                            let action = UIAlertAction(title: "Oke", style: .default, handler: { (UIAlertAction) in
                                self.dismiss(animated: true, completion: nil)
                            })
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                        }
                        else{
                            self.setView()
                        }
                        
                    }
                    
                }
                else{
                    print("Loiii")
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Error", message: "\nPlease try again!", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                }
            }
        }
        // Do any additional setup after loading the view.
    }
        
    func setView(){
        if let an = anime{
            if let des = an.synopsis{
                lbDes.text = des
            }
            else{
                viewDes.isHidden = true
            }
            if let title = an.title{
                lbTitle.text = title
            }
            else{
                viewTitle.isHidden = true
            }
            if let eTitle = an.title_english{
                lbEnglishTitle.text = eTitle
            }
            else{
                viewEtitle.isHidden = true
            }
            if let jTitle = an.title_japanese{
                lbJapanTitle.text = jTitle
            }
            else{
                viewJTitle.isHidden = true
            }
            if let du = an.duration{
                lbDuration.text = du
            }
            if let rate = an.rating {
                lbRate.text = rate
                
            }
            if let url = an.image_url{
                imgImage.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "default"))
            }
            viewContent.alpha = 0
            UIView.animate(withDuration: 0.5, delay: 1, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                self.viewContent.alpha = 1
                self.viewContent.isHidden = false
            }, completion: nil)
            
            
        }
    }

}
