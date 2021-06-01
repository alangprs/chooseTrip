

import Foundation

struct OderResponse:Decodable {
    let records:[OderFields]
}
struct OderFields:Decodable {
    let fields:OderData
}
struct OderData:Decodable {
    let StrokeName:String
    let NumberOfPeople:Int
    let PhoneNumber:String
    let Name:String
    let IDNumber:String
    let Birthday:String
    let TotalSum:Int
}
