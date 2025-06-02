import Foundation

class CSVParser {
    func parseCSV(from fileURL: URL) -> [Restaurant]? {
        guard let csvData = try? String(contentsOf: fileURL, encoding: .utf8) else {
            print("Ошибка чтения CSV-файла: \(fileURL)")
            return nil
        }
        
        let cleanedData = csvData.replacingOccurrences(of: "\r", with: "")
        let rows = cleanedData.components(separatedBy: "\n").dropFirst() // Пропускаем заголовок
        var restaurants: [Restaurant] = []
        
        for row in rows {
            let columns = row.components(separatedBy: ";")
            guard columns.count == 9 else {
                continue
            }
            
            let restaurant = Restaurant(
                name: columns[1],
                address: columns[3],
                metro: columns[4],
                cuisine: columns[7],
                imageUrl: columns[8]
            )
            restaurants.append(restaurant)
        }
        return restaurants
    }
}
