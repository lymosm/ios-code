struct ServerConfig {
    var server: String
    var port: Int
    var password: String
    var method: String
    
    static let defaultConfig = ServerConfig(
        server: "your.server.com",
        port: 8388,
        password: "yourpassword",
        method: "aes-256-cfb"
    )
}
