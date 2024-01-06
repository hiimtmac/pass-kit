//
//  File.swift
//  
//
//  Created by Taylor McIntyre on 2024-01-06.
//

import PassCore
import Foundation
import ZIPFoundation

public enum PassReader {
    public static func parse(from data: Data) throws -> PassContainer<String> {
        guard let archive = Archive(data: data, accessMode: .read) else {
            throw Error.archive
        }
        
        guard let passEntry = archive["pass.json"] else {
            throw Error.entry("pass.json")
        }
        
        guard let iconEntry = archive["icon@3x.png"] else {
            throw Error.entry("icon@3x.png")
        }
        
        var pass: Pass?
        _ = try archive.extract(passEntry) { data in
            pass = try JSONDecoder.passKit.decode(Pass.self, from: data)
        }
        
        var icon: String?
        _ = try archive.extract(iconEntry) { data in
            icon = data.base64EncodedString()
        }
        
        guard let pass else {
            throw Error.parsed("Pass")
        }
        
        guard let icon else {
            throw Error.parsed("icon")
        }
        
        return try .init(
            pass: pass,
            icon: icon,
            logo: imageData(for: "logo", in: archive)?.base64EncodedString(),
            strip: imageData(for: "strip", in: archive)?.base64EncodedString(),
            footer: imageData(for: "footer", in: archive)?.base64EncodedString(),
            thumbnail: imageData(for: "thumbnail", in: archive)?.base64EncodedString(),
            background: imageData(for: "background", in: archive)?.base64EncodedString()
        )
    }
    
    enum Error: Swift.Error {
        case archive
        case entry(String)
        case parsed(String)
    }
    
    static func imageData(
        for name: String,
        in archive: Archive
    ) throws -> Data? {
        guard let entry = archive["\(name)@3x.png"] else {
            return nil
        }
        
        var data: Data?
        _ = try archive.extract(entry) { data = $0 }
        
        return data
    }
}
