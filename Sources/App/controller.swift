import Vapor
import Fluent

final class Controller: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.get(use: test)
    }
    
    func test(req: Request) async throws -> [String] {
        async let ones = One.query(on: req.db).all()
        async let twos = Two.query(on: req.db).all()
        
        var data = [String]()
        
        for id in ["1", "2", "3"] {
            guard let one = (try await ones).first(where: { $0.test == id }) else { continue }
            let two = (try await twos).filter { $0.test == id }.count
            
            data.append("\(one.test)-\(two)")
        }
        
        return data
    }
}
