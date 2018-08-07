//
//  MangaModel.swift
//  FinalProject
//
//  Created by kien on 8/6/18.
//  Copyright © 2018 kien. All rights reserved.
//

import Foundation
class MangaModel: Codable{
    var error: String?
    var mal_id: Int?
    var name: String?
    var name_kanji: String?
    var nicknames: String?
    var about: String?
    var image_url: String?
    var animeography : [PeopleModel]?
    var mangaography : [PeopleModel]?
    var voice_actor: [PeopleModel]?
    var image: [String]?
}
