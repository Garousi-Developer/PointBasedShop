extension Array {
    func indexOfDifferencesFrom(_ secondArray: [Any]) -> [Int] {
        let firstMappedArray: [AnyHashable?]
        let secondMappedArray: [AnyHashable?]
        firstMappedArray = self.map { (firstElement) -> AnyHashable? in
            switch firstElement {
            case is NewProduct:
                let newProduct = firstElement as! NewProduct
                return newProduct.id
            default:
                return nil
            }
        }
        secondMappedArray = secondArray.map { (secondElement) -> AnyHashable? in
            switch secondElement {
            case is NewProduct:
                let newProduct = secondElement as! NewProduct
                return newProduct.id
            default:
                return nil
            }
        }
        
        let firstSet = Set(firstMappedArray)
        let secondSet = Set(secondMappedArray)
        let differences = firstSet.symmetricDifference(secondSet)
        let indexOfDifferences = differences.map { (difference) -> Int in
            return firstMappedArray.firstIndex(of: difference)!
        }
        
        return indexOfDifferences
    }
}
