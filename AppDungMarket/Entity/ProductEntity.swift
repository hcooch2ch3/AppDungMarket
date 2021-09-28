//
//  Product.swift
//  AppDungMarket
//
//  Created by 임성민 on 2021/09/15.
//

import Foundation

struct ProductEntity: Decodable {
    let id: String
    let name: String
    let price: Int
    let discountedPrice: Int
    let brandName: String?
    let thumbnailURL: String
    let detailPageURL: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case price
        case salePrice
        case brand
        case thumbnailURL
        case detailPageURL
        case original
        case sale
        case raw
        case url
        case meta
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        let prices = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .price)
        let originalPrice = try prices.nestedContainer(keyedBy: CodingKeys.self, forKey: .original)
        price = try originalPrice.decode(Int.self, forKey: .raw)
        let salePrice = try prices.nestedContainer(keyedBy: CodingKeys.self, forKey: .sale)
        discountedPrice = try salePrice.decode(Int.self, forKey: .raw)
        let brand = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: .brand)
        brandName = try brand?.decode(String.self, forKey: .name)
        let meta = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .meta)
        thumbnailURL = try meta.decode(String.self, forKey: .thumbnailURL)
        detailPageURL = try meta.decode(String.self, forKey: .detailPageURL)
    }
}
