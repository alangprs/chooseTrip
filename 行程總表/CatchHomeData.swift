//下載GV行程總表資料

import Foundation

struct RecordsResponse:Decodable {
    let records:[Fields]
}
struct Fields:Decodable {
    let fields:TripData
    
}

struct TripData:Decodable {
    let TripItme:String
    let Data:String
    let Number:String
    let Name:String
    let Image:String
    let Price:Int
    let TripData:String
    
}
