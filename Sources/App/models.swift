import Fluent

final class One: Model {
    static let schema = "ones"
    
    @ID(custom: .id) var id: Int?
    @Field(key: "test") var test: String
    
    init() {}
    
    init(id: Int? = nil, test: String) {
        self.id = id
        self.test = test
    }
}

final class Two: Model {
    static let schema = "twos"
    
    @ID(custom: .id) var id: Int?
    @Field(key: "test") var test: String
    
    init() {}
    
    init(id: Int? = nil, test: String) {
        self.id = id
        self.test = test
    }
}
