import Vapor
import Fluent

final class Controller: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.get(use: test)
    }
    
    func test(req: Request) async throws -> [String] {
        let threes = try await Three.query(on: req.db).all()
        
        async let ones = One.query(on: req.db).all()
        async let twos = Two.query(on: req.db).all()
        
        var data = [String]()
        
        for three in threes {
            guard let one = (try await ones).first(where: { $0.test == three.test }) else { continue }
            let two = (try await twos).filter { $0.test == three.test }.count
            
            data.append("\(one.test)-\(two)-\(three.test)")
        }
        
        return data
    }
}
