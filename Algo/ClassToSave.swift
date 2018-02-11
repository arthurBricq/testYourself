//
//  ClassToSave.swift
//  testYourself
//
//  Created by Marin on 10/02/2018.
//  Copyright © 2018 Arthur BRICQ. All rights reserved.
//

import Foundation
import UIKit

class OneScore: NSObject, NSCoding {
    var name: String
    var gender: String
    var nameOfQuizz: String
    var scores: [CGFloat]
    
    init(name: String, gender: String, nameOfQuizz: String, scores: [CGFloat]) {
        self.name = name
        self.gender = gender
        self.nameOfQuizz = nameOfQuizz
        self.scores = scores
    }
    
    // Coding:
    struct PropertyKeys {
        static let name = "name"
        static let gender = "gender"
        static let nameOfQuizz = "nameOfQuizz"
        static let scores = "scores"
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: PropertyKeys.name) as? String,
            let gender = aDecoder.decodeObject(forKey: PropertyKeys.gender) as? String,
            let nameOfQuizz = aDecoder.decodeObject(forKey: PropertyKeys.nameOfQuizz) as? String,
            let scores = aDecoder.decodeObject(forKey: PropertyKeys.scores) as? [CGFloat] else { return nil }
        self.init(name: name, gender: gender, nameOfQuizz: nameOfQuizz, scores: scores)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKeys.name)
        aCoder.encode(gender, forKey: PropertyKeys.gender)
        aCoder.encode(nameOfQuizz, forKey: PropertyKeys.nameOfQuizz)
        aCoder.encode(scores, forKey: PropertyKeys.scores)
    }
}

var archiveURL: URL {
    let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    return documentsURL.appendingPathComponent("FUCKIT4")
}

func saveToFile(toSave: [OneScore]) {
    NSKeyedArchiver.archiveRootObject(toSave, toFile: archiveURL.path)
    print("The array of score have been saved correctly.")
}

func loadFromFile() -> [OneScore] {
    guard let toReturn = NSKeyedUnarchiver.unarchiveObject(withFile: archiveURL.path) as? [OneScore] else {
        print("impossible to load files")
        return []
    }
    return toReturn
}
