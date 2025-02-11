//
//  UnSplashModel.swift
//  UnSplash Assignment
//
//  Created by Ashwin Jagarwal on 28/01/25.
//


struct Pic: Hashable, Codable, Identifiable {
    let id: String
    let clientId: String?
    let width: Int
    let height: Int
    let color: String
    let description: String?
    let urls: URLs
    let likes: Int?
    let publisher: String?
    
    struct URLs: Hashable, Codable {
        let raw: String
        let full: String
        let regular: String
        let small: String
        let thumb: String
        let small_s3: String
    }
}


