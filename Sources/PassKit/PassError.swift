import Foundation

enum PassError: Error {
    case nonEmptyDirectory
    case passWrite
    case manifestWrite
}
