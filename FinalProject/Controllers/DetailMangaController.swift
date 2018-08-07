//
//  DetailMangaController.swift
//  FinalProject
//
//  Created by kien on 8/6/18.
//  Copyright © 2018 kien. All rights reserved.
//

import UIKit

class DetailMangaController: UIViewController {

    @IBOutlet weak var lbTitleNavigation: UILabel!
    @IBOutlet weak var viewDes: UIStackView!
    @IBOutlet weak var viewJTitle: UIStackView!
    @IBOutlet weak var viewEtitle: UIStackView!
    @IBOutlet weak var viewTitle: UIStackView!
    @IBOutlet weak var imgImage: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbEnglishTitle: UILabel!
    @IBOutlet weak var lbJapanTitle: UILabel!
    @IBOutlet weak var lbDes: UILabel!
    @IBOutlet weak var collectionAnime: UICollectionView!
    @IBOutlet weak var collectionManga: UICollectionView!
    @IBOutlet weak var collectionVoice: UICollectionView!
    @IBOutlet weak var viewAnime: UIStackView!
    @IBOutlet weak var viewManga: UIStackView!
    @IBOutlet weak var viewVoice: UIStackView!
    @IBOutlet weak var collectionImage: UICollectionView!
    @IBOutlet weak var viewContent: UIView!
    
    @IBOutlet weak var viewImage: UIStackView!
    @IBAction func actionClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    var manga: MangaModel?
    var item: ItemModel?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpTableView()
        viewContent.isHidden = true
        if let title = item?.title{
            self.lbTitleNavigation.text = title
        }
        else{
            self.lbTitleNavigation.text = ""
        }
        if let ID = item?.mal_id{
            NetWorkManager.shared.getDetailManga(id: ID) { (manga) in
                if let m = manga{
                    self.manga = m
                    DispatchQueue.main.async {
                          self.setUpView()
                    }
                  
                }
            }
        }
    }
    
    func setUpTableView(){
        collectionAnime.register(UINib(nibName: "PeopleViewCell", bundle: nil), forCellWithReuseIdentifier: "PeopleAnimaViewCell")
        collectionAnime.dataSource = self
        collectionAnime.delegate = self
        collectionManga.register(UINib(nibName: "PeopleViewCell", bundle: nil), forCellWithReuseIdentifier: "PeopleMangaViewCell")
        collectionManga.dataSource = self
        collectionManga.delegate = self
        collectionVoice.register(UINib(nibName: "PeopleViewCell", bundle: nil), forCellWithReuseIdentifier: "PeopleVoicViewCell")
        collectionVoice.dataSource = self
        collectionVoice.delegate = self
        collectionImage.register(UINib(nibName: "ImageViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageViewCell")
        collectionImage.dataSource = self
        
        
    }
    
    func setUpView(){
        if let man = manga{
            if let title = man.name{
                lbTitle.text = title
            }
            else{
                viewTitle.isHidden = true
            }
            if let nick = man.nicknames{
                lbEnglishTitle.text = nick
            }
            else{
                viewEtitle.isHidden = true
            }
            if let jTitle = man.name_kanji{
                lbJapanTitle.text = jTitle
            }
            else{
                viewJTitle.isHidden = true
            }
            if let about = man.about{
                lbDes.text = about
            }
            if let url = man.image_url{
                imgImage.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "default"))
            }
            if let animeography = man.animeography{
                if animeography.count > 0{
                    collectionAnime.reloadData()
                }
                else{
                    viewAnime.isHidden = true
                }
            }
            if let mangaography = man.mangaography{
                if mangaography.count > 0{
                    collectionManga.reloadData()
                }
                else{
                    viewManga.isHidden = true
                }
            }
            if let voice_actor = man.voice_actor{
                if voice_actor.count > 0{
                    collectionVoice.reloadData()
                }
                else{
                    viewVoice.isHidden = false
                }
            }
            if let images = man.image{
                if images.count > 0{
                    collectionImage.reloadData()
                }
                else{
                    viewImage.isHidden = true
                }
            }
            viewContent.alpha = 0
            UIView.animate(withDuration: 0.5, delay: 1, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                self.viewContent.alpha = 1
                self.viewContent.isHidden = false
            }, completion: nil)
        }
    }

}

extension DetailMangaController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionAnime{
            guard let count = manga?.animeography?.count else{
                return 0
            }
            return count
        }
        else if collectionView == collectionManga{
            guard let count = manga?.mangaography?.count else{
                return 0
            }
            return count
        }
        else if collectionView == collectionVoice{
            guard let count = manga?.voice_actor?.count else{
                return 0
            }
            return count
        }
        else{
            guard let count = manga?.image?.count else{
                return 0
            }
            return count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionAnime{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PeopleAnimaViewCell", for: indexPath) as? PeopleViewCell else{
                return UICollectionViewCell()
            }
            if let list = manga?.animeography{
                cell.set(peo: list[indexPath.row])
            }
            return cell
        }
        else if collectionView == collectionManga{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PeopleMangaViewCell", for: indexPath) as? PeopleViewCell else{
                return UICollectionViewCell()
            }
            if let list = manga?.mangaography{
                cell.set(peo: list[indexPath.row])
            }
            return cell
        }
        else if collectionView == collectionVoice {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PeopleVoicViewCell", for: indexPath) as? PeopleViewCell else{
                return UICollectionViewCell()
            }
            if let list = manga?.voice_actor{
                cell.set(peo: list[indexPath.row])
            }
            return cell
        }
        else{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageViewCell", for: indexPath) as? ImageViewCell else{
                return UICollectionViewCell()
            }
            if let images = manga?.image{
                cell.set(url: images[indexPath.row])
            }
            return cell
        }
    }
}
extension DetailMangaController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionAnime{
            if let animeography = manga?.animeography{
                guard let urlString = animeography[indexPath.row].url else{
                    return
                }
                guard let url = URL(string : urlString) else{
                    return
                }
                UIApplication.shared.open(url, options: [:], completionHandler: { (status) in})
                
            }
        }
        else if collectionView == collectionManga{
            if let mangaography = manga?.mangaography{
                guard let urlString = mangaography[indexPath.row].url else{
                    return
                }
                guard let url = URL(string : urlString) else{
                    return
                }
                UIApplication.shared.open(url, options: [:], completionHandler: { (status) in})
                
            }
        }
        else{
            
        }
    }
}

