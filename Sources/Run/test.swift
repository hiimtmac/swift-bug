import Foundation

@main
struct SwiftBug {
    static func main() async throws {
        print("starting")
        
        try await iWillDie()

        print("done")
    }
    
    static func iWillDie() async throws {
        async let ones = doAsync()
        async let twos = doAsync()
        
        print(try await ones)
        if false {
            print(try await twos)
        }
    }
    
    static func doAsync() async throws -> [Int] {
        [1]
    }
}
