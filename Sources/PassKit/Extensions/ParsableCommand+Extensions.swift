import Foundation
import ArgumentParser

extension ParsableCommand {
    public static func folderTransform(_ string: String) throws -> URL {
        URL(fileURLWithPath: string, isDirectory: true)
    }

    public static func fileTransform(_ string: String) throws -> URL {
        URL(fileURLWithPath: string)
    }
}
