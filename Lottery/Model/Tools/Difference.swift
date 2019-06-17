extension Array {
    func indexOfDifferenceFrom(_ secondArray: [Any]) -> Int! {
        let mappedFirstArray: [AnyHashable]
        let mappedSecondArray: [AnyHashable]
        
        switch self[0] {
        case is NewProduct:
            let firstProducts = self as! [NewProduct]
            let secondProducts = secondArray as! [NewProduct]
            
            mappedFirstArray = firstProducts.map({ (product) -> Int in
                return product.id
            })
            mappedSecondArray = secondProducts.map({ (product) -> Int in
                return product.id
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
