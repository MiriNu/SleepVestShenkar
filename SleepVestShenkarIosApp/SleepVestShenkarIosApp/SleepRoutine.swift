//
//  SleepRoutine.swift
//  SleepVestShenkarIosApp
//
//  Created by Marin postma on 04/06/2017.
//  Copyright © 2017 Marin postma. All rights reserved.
//

import Foundation

protocol SleepRoutineDelegate {
    func updateLabels()
}

enum SleepType: String {
    case uberman = "uberman"
    case everyman = "everyman"
    case dymaxion = "dymaxion"
    case monophasic = "monophanic"
    case biphasic = "biphasic"
    case test = "test"
}

class SleepRoutine {
    
    var delegate: SleepRoutineDelegate?
    
    var url: URL {
        get {
            let urlString = "http://localhost:8080/\(self.sleepType)/\(self.ledLevel)/\(self.wakeUp)/\(self.sleep)"
            return URL(string: urlString)!
        }
    }
    
    var getUrl = URL(string: "http://localhost:8080/node")!
    
    var sleep: Bool = false
    var wakeUp: Bool = false
    var ledLevel: Int = 0
    var sleepType: SleepType = .test
    let session = URLSession.shared
    
    func datafetch() {
        
        
        let dataTask = session.dataTask(with: getUrl){
             data, response, error in
            guard error == nil else {
                print("there was an error : \(String(describing: error))")
                return
            }
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                if let data = data{
                    do {
                        let jsonDic = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        if let dic = jsonDic {
                            self.sleep = dic["sleep"]! as! Bool
                            self.wakeUp = dic["wakeUp"]! as! Bool
                            self.ledLevel = dic["ledLevel"]! as! Int
                        }
                        print(self.ledLevel)
                        self.delegate?.updateLabels()
                    } catch {
                        print("json error : \(error)")
                    }
                    
                }
                
            }
        }
        dataTask.resume()
    }
    
    
    func sendData(){
        let task = session.dataTask(with: url ){_,_,_ in
            print("done")
        }
        task.resume()
    }
}
