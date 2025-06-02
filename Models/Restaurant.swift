struct Restaurant {
    let name: String
    let address: String
    let metro: String
    let cuisine: String
    let imageUrl: String
}

extension Restaurant {
    static func mock() -> Restaurant {
        return Restaurant(
            name: "Test Restaurant",
            address: "Test Address 123",
            metro: "Test Metro",
            cuisine: "Test Cuisine",
            imageUrl: "ttttt.jpg"
        )
    }
}
