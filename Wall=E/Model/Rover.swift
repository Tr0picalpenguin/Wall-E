//
//  Rover.swift
//  Wall-E
//
//  Created by Scott Cox on 8/7/22.
//

import Foundation

struct TopLevelDictionary: Decodable {
    let photos: Photo
}

struct Photo: Decodable {
    let id: Int
    let camera: Camera
    let earth_date: String
    let rover: Rover
    let img_src: String
}

struct Camera: Decodable {
    let id: Int
    let name: String
}

struct Rover: Decodable {
    let id: Int
    let name: String
}
