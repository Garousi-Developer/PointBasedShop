extension Array {
    func indexOfDifferenceFrom(_ secondArray: [Any]) -> Int! {
        let mappedFirstArray: [AnyHashable]
        let mappedSecondArray: [AnyHashable]
        
        switch self[0] {
        case is Product:
            let firstProducts = self as! [Product]
            let secondProducts = secondArray as! [Product]
            
            mappedFirstArray = firstProducts.map({ (product) -> String in
                return product.name
            })
            mappedSecondArray = secondProducts.map({ (product) -> String in
                return product.name
            })
        default:
            return nil
        }
        
        let firstSet = Set(mappedFirstArray)
        let secondSet = Set(mappedSecondArray)
        let difference = firstSet.symmetricDifference(secondSet).first!
        
        return mappedFirstArray.firstIndex(of: difference)
    }
}
