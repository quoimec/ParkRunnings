//
//  Array.swift
//  ParkRun WatchKit Extension
//
//  Created by Charlie on 9/4/2022.
//

import Foundation

extension Array {
    
    func chunked(into size: Int) -> [[Element]] {
        
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
        
    }
    
}
