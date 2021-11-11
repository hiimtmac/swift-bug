import Vapor
import Fluent
import FluentMySQLDriver

// configures your application
public func configure(_ app: Application) throws {
    
    var tlsObject = TLSConfiguration.makeClientConfiguration()
    tlsObject.certificateVerification = .none
        
    app.databases.use(.mysql(
        configuration: .init(
            hostname: Environment.get("HOSTNAME")!,
            username: Environment.get("USERNAME")!,
            password: Environment.get("PASSWORD")!,
            database: Environment.get("DATABASE")!,
            tlsConfiguration: tlsObject
        )
    ), as: .mysql)
    
    app.migrations.add(OneMigration())
    app.migrations.add(TwoMigration())
    app.migrations.add(ThreeMigration())
    app.migrations.add(SeedMigration())
    
    try app.autoMigrate().wait()
    
    // register routes
    try routes(app)
}
