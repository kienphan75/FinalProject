//
//  NetWorkManager.swift
//  FinalProject
//
//  Created by kien on 8/6/18.
//  Copyright © 2018 kien. All rights reserved.
//

import Foundation

class NetWorkManager{
    static let shared = NetWorkManager()
    let baseUrl = "https://api.jikan.moe/"

    func get(type: String,page: Int,category: String,completion: @escaping ([ItemModel]?) -> Void) {
        let finalUrlString = baseUrl + "top/\(type)/\(page)/\(category)"
        guard let url = URL(string: finalUrlString) else {
            completion(nil)
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            print("start")
            if let _ = error {
                print("orr")
                completion(nil)
            }
            guard let data = data else {
                print("ok")
                completion([])
                return
            }
            do {
                let parse = try JSONDecoder().decode(ParseModel.self, from: data)
                if let list = parse.top{
                    print("\(list.count)")
                    completion(list)
                }
            }catch let e {
                print(e)
            }
        }
        task.resume()
    }
    
    func getDetailAnime(id: Int, page : Int, completion: @escaping (AnimeModel?) -> Void){
//        https://api.jikan.moe/anime/1/episodes/1
        let finalUrl = baseUrl + "anime/\(id)/episodes/\(page)"
        guard let url = URL(string: finalUrl) else {
            completion(nil)
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            print("start")
            if let _ = error {
                print("orr")
                completion(nil)
                return
            }
            guard let data = data else {
                completion(nil)
                return
            }
            do {
                
                let anime = try JSONDecoder().decode(AnimeModel.self, from: data)
                completion(anime)
            }catch let e {
                print(e)
            }
        }
        task.resume()
    }
    
    func getDetailManga(id: Int, completion: @escaping (MangaModel?) -> Void){
//        https://api.jikan.moe/character/1/pictures
        let finalUrl = baseUrl + "character/\(id)/pictures"
        guard let url = URL(string: finalUrl) else {
            completion(nil)
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            print("start")
            if let _ = error {
                print("orr")
                completion(nil)
                return
            }
            guard let data = data else {
                completion(nil)
                return
            }
            do {
                let manga = try JSONDecoder().decode(MangaModel.self, from: data)
                completion(manga)
            }catch let e {
                print(e)
            }
        }
        task.resume()
    }
    
    
    
}
