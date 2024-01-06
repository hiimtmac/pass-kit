//
//  File.swift
//  
//
//  Created by Taylor McIntyre on 2024-01-06.
//

import PassCore
import Foundation
import ZIPFoundation

public struct PassReader {
    let archive: Archive
    
    public init(data: Data) throws {
        guard let archive = Archive(data: data, accessMode: .read) else {
            throw Error.archive
        }
        
        self.archive = archive
    }
    
    // TODO: need to use data before extracting another
    public func extract(
        path: String,
        bufferSize: Int = defaultReadChunkSize
    ) throws -> Data {
        guard let entry = archive[path] else {
            throw Error.entry(path)
        }
        
        var data: Data?
        _ = try archive.extract(entry, bufferSize: bufferSize) { data = $0 }
        
        guard let data else {
            throw Error.data(path)
        }
        
        return data
    }
    
    public func optionallyExtract(
        path: String,
        bufferSize: Int = defaultReadChunkSize
    ) throws -> Data? {
        guard let entry = archive[path] else {
            return nil
        }
        
        var data: Data?
        _ = try archive.extract(entry, bufferSize: bufferSize) { data = $0 }
        
        return data
    }
    
    enum Error: Swift.Error {
        case archive
        case entry(String)
        case data(String)
    }
}
