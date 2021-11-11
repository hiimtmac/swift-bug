import Fluent

struct OneMigration: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("ones")
            .field("id", .int, .identifier(auto: true))
            .field("test", .string, .required)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("ones").delete()
    }
}

struct TwoMigration: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("twos")
            .field("id", .int, .identifier(auto: true))
            .field("test", .string, .required)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("twos").delete()
    }
}

struct ThreeMigration: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("threes")
            .field("id", .int, .identifier(auto: true))
            .field("test", .string, .required)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("threes").delete()
    }
}

struct SeedMigration: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        let saves = [
            One(test: "1").save(on: database),
            One(test: "2").save(on: database),
            One(test: "3").save(on: database),
            One(test: "4").save(on: database),
            Two(test: "1").save(on: database),
            Two(test: "2").save(on: database),
            Two(test: "3").save(on: database),
            Two(test: "4").save(on: database),
            Three(test: "1").save(on: database),
            Three(test: "2").save(on: database),
            Three(test: "3").save(on: database),
            Three(test: "4").save(on: database)
        ]

        return saves.flatten(on: database.eventLoop)
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.makeSucceededVoidFuture()
    }
}
