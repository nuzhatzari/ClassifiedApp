//
//  ConverterItem.swift
//  CurrenyConverter
//
//  Created by Nuzhat Zari on 18/02/21.
//

import UIKit

class Product: NSObject, Decodable {
    /**
    *  Attributes here
    */
    @objc var uid: String = ""
    @objc var name: String = ""
    @objc var price: String = ""
    @objc var image_urls_thumbnails: [String] = []
    @objc var image_urls: [String] = []

    init(uid: String, name: String, thumbnails: [String], images: [String]) {
        self.uid = uid
        self.name = name
        self.image_urls_thumbnails = thumbnails
        self.image_urls = images
    }
}
