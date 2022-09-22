//
//  Models.swift
//  CameraDemo
//
//  Created by PPG on 21.09.22.
//

import Foundation
import SwiftUI

struct DataModel: Decodable {
    let error: Bool
    let message: String
    let data: [PostModel]
}


struct PostModel: Decodable{
    let id: Int
    let title:String
    let post: String
}

