//
//  UploadData.swift
//  選購旅遊行程
//
//  Created by 翁燮羽 on 2021/5/24.
// 上傳資料

import Foundation

struct UploadData:Encodable {
    let records:[Fieldss]
}
struct Fieldss:Encodable {
    let fields:UpData
}
struct UpData:Encodable {
    let StrokeName:String
    let Name:String
    let Birthday:String
    let IDNumber:String
    let PhoneNumber:String
    
    
}
