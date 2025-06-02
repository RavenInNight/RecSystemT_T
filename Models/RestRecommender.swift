import Foundation

// MARK: - Рекомендатель ресторанов
class RestaurantRecommender {
    private(set) var restaurants: [Restaurant] = []
    
    // Веса признаков (категориальные)
    private var categoricalFeatureWeights: [String: Double] = [:]
    
    // Матрицы сходства для cuisine и metro
    // Формат: [feature: [value1: [value2: similarity]]]
    private var similarityMatrices: [String: [String: [String: Double]]] = [:]
    
    // Матрица близости (NxN)
    private var proximityMatrix: [[Double]] = []
    
    private func loadCSV(from fileName: String) -> [[String]]? {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "csv") else {
            print("Файл \(fileName).csv не найден")
            return nil
        }
        do {
            let content = try String(contentsOfFile: path, encoding: .utf8)
            var rows: [[String]] = []
            let lines = content.components(separatedBy: .newlines).filter { !$0.isEmpty }
            for line in lines {
                let columns = line.components(separatedBy: ";")
                rows.append(columns)
            }
            return rows
        } catch {
            print("Ошибка чтения файла \(fileName).csv: \(error)")
            return nil
        }
    }
    
    func loadData(restaurants: String,
                  cuisineSimilarity: String,
                  metroSimilarity: String,
                  featureWeights: [String: Double]) -> Bool {
        
        // Загрузка ресторанов
        guard let restaurantRows = loadCSV(from: restaurants) else { return false }
        guard restaurantRows.count > 1 else {
            print("Файл ресторанов пуст или содержит только заголовок")
            return false
        }
        
        let header = restaurantRows[0]
        guard let nameIndex = header.firstIndex(of: "name"),
              let cuisineIndex = header.firstIndex(of: "cuisine"),
              let addressIndex = header.firstIndex(of: "address"),
              let metroIndex = header.firstIndex(of: "metro"),
              let imageIndex = header.firstIndex(of: "photo") else {
            print("В CSV ресторанах должны быть колонки 'name', 'cuisine', 'metro', 'photo' ")
            return false
        }
        
        var loadedRestaurants: [Restaurant] = []
        for row in restaurantRows.dropFirst() {
            if row.count > max(nameIndex, cuisineIndex, metroIndex, imageIndex) {
                let restaurant = Restaurant(name: row[nameIndex],
                                            address: row[addressIndex],
                                            metro: row[metroIndex],
                                            cuisine: row[cuisineIndex],
                                            imageUrl: row[imageIndex])
                loadedRestaurants.append(restaurant)
            }
        }
        self.restaurants = loadedRestaurants
        
        // Загрузка матриц сходства
        guard let cuisineSim = parseSimilarityCSV(fileName: cuisineSimilarity) else { return false }
        guard let metroSim = parseSimilarityCSV(fileName: metroSimilarity) else { return false }
        
        self.similarityMatrices["cuisine"] = cuisineSim
        self.similarityMatrices["metro"] = metroSim
        
        // Веса признаков
        self.categoricalFeatureWeights = featureWeights
        
        // Вычисляем матрицу близости
        calculateProximityMatrix()
        
        return true
    }
    
    // MARK: - Парсинг матрицы сходства из CSV
    private func parseSimilarityCSV(fileName: String) -> [String: [String: Double]]? {
        guard let rows = loadCSV(from: fileName) else { return nil }
        guard rows.count > 1 else { return nil }
        
        let header = rows[0].dropFirst()
        var similarityDict: [String: [String: Double]] = [:]
        
        for row in rows.dropFirst() {
            guard row.count == header.count + 1 else { continue }
            let rowKey = row[0]
            var rowValues: [String: Double] = [:]
            for (index, colKey) in header.enumerated() {
                if let val = Double(row[index + 1]) {
                    rowValues[colKey] = val
                }
            }
            similarityDict[rowKey] = rowValues
        }
        return similarityDict
    }
    
    // MARK: - Вычисление схожести между двумя ресторанами
    private func calculateSimilarity(_ r1: Restaurant, _ r2: Restaurant) -> Double {
        var similarities: [Double] = []
        
        // cuisine
        if let cuisineSimMatrix = similarityMatrices["cuisine"],
           let row = cuisineSimMatrix[r1.cuisine],
           let sim = row[r2.cuisine],
           let weight = categoricalFeatureWeights["cuisine"] {
            similarities.append(sim * weight)
        }
        
        // metro
        if let metroSimMatrix = similarityMatrices["metro"],
           let row = metroSimMatrix[r1.metro],
           let sim = row[r2.metro],
           let weight = categoricalFeatureWeights["metro"] {
            similarities.append(sim * weight)
        }
        
        if similarities.isEmpty { return 0.0 }
        
        // Среднее взвешенное
        let similaritySum = similarities.reduce(0, +)
        let weightSum = categoricalFeatureWeights.values.reduce(0, +)
        return similaritySum / weightSum
    }
    
    // MARK: - Вычисление матрицы близости
    private func calculateProximityMatrix() {
        let n = restaurants.count
        proximityMatrix = Array(repeating: Array(repeating: 1.0, count: n), count: n)
        
        for i in 0..<n {
            for j in (i+1)..<n {
                let sim = calculateSimilarity(restaurants[i], restaurants[j])
                proximityMatrix[i][j] = sim
                proximityMatrix[j][i] = sim
            }
        }
    }
    
    // MARK: - Получение рекомендаций
    func getRecommendations(selectedCuisines: [String], topN: Int? = nil) -> [(restaurant: Restaurant, similarityScore: Double)] {
        let n = restaurants.count
        var scores = Array(repeating: 0.0, count: n)
        
        guard let cuisineSimMatrix = similarityMatrices["cuisine"],
              let cuisineWeight = categoricalFeatureWeights["cuisine"],
              let metroWeight = categoricalFeatureWeights["metro"] else {
            print("Матрица сходства кухни или веса не загружены")
            return []
        }
        
        for i in 0..<n {
            let restaurant = restaurants[i]
            
            // Считаем максимальную схожесть кухни ресторана к выбранным кухням
            var maxCuisineSim: Double = 0.0
            for selectedCuisine in selectedCuisines {
                if let row = cuisineSimMatrix[restaurant.cuisine],
                   let sim = row[selectedCuisine] {
                    maxCuisineSim = max(maxCuisineSim, sim)
                }
            }
            let weightedCuisineSim = maxCuisineSim * cuisineWeight
            
            // Для метро можно оставить среднее значение 1.0 (если не учитываем) или 0
            // Или, например, средний вес, если учитывать:
            let weightedMetroSim = metroWeight // либо 0, если не учитывать
            
            // Итоговый скор (усредненный по сумме весов)
            let totalWeight = cuisineWeight + metroWeight
            let combinedScore = (weightedCuisineSim + weightedMetroSim) / totalWeight
            
            scores[i] = combinedScore
        }
        
        // Формируем список рекомендаций
        var recommendations: [(Restaurant, Double)] = []
        for i in 0..<n {
            recommendations.append((restaurants[i], scores[i]))
        }
        
        // Сортируем по убыванию схожести
        recommendations.sort { $0.1 > $1.1 }
        
        if let topN = topN, topN < recommendations.count {
            return Array(recommendations.prefix(topN))
        } else {
            return recommendations
        }
    }
}
