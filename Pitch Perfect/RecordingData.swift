//
//  RecordingData.swift
//  Pitch Perfect
//
//  Created by Chitradip Mandal on 3/24/15.
//  Copyright (c) 2015 Chitradip Mandal. All rights reserved.
//

import Foundation

class RecordingData :NSObject {
    let fileName: String!
    let filePath: NSURL!
    init(fileName:String, filePath:NSURL) {
        self.fileName = fileName
        self.filePath = filePath
    }
}
