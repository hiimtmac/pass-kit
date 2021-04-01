import Foundation
import ZIPFoundation

extension Data {
    func zipProvider(position: Int, size: Int) throws -> Data {
        self.subdata(in: position..<(position + size))
    }
}
