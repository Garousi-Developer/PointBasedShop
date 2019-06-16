import UIKit
import Alamofire

@discardableResult
func request(_ requestHolder: RequestHolder) -> RequestHolder {
    let debuggingIsEnabled = Settings.model().debuggingIsEnabled
    let endPoint = endPoints(requestHolder.endPointName)
    let dataRequest = request(
        endPoint.url,
        method: endPoint.method,
        parameters: endPoint.parameters,
        encoding: endPoint.encoding,
        headers: endPoint.headers
    )
    
    if debuggingIsEnabled {
//        if endPoint.method == .get || endPoint.method == .delete {
//            print("Requesting \(dataRequest)...")
//        }
//        else {
//
//        }
        if let endPointParameters = endPoint.parameters {
            print("Requesting \(dataRequest) \(endPointParameters)...")
        }
        else {
            print("Requesting \(dataRequest)...")
        }
    }
    
    UIApplication.shared.keyWindow!.endEditing(true)
    UIApplication.shared.keyWindow!.isUserInteractionEnabled = false
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    
    dataRequest
        .validate()
        .responseData { response in
            let responseJSON = try? JSONSerialization.jsonObject(with: response.data!, options: [])
            
            if debuggingIsEnabled {
                if let responseResponse = response.response {
                    if let responseJSON = responseJSON {
                        print("Responded \(responseResponse.statusCode) \(responseJSON).")
                    }
                    else {
                        let responseString = String(data: response.data!, encoding: .utf8)
                        print("Responded \(responseResponse.statusCode) \(responseString ?? "").")
                    }
                }
                else {
                    print("Responded with no response.")
                }
                
                print("Responded in \(response.timeline)")
            }
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            UIApplication.shared.keyWindow!.isUserInteractionEnabled = true
            
            switch response.result {
            case .success(let body):
                if let endPointResponse = endPoint.response {
                    requestHolder.didSucceed(endPointResponse.model(body))
                }
                else {
                    requestHolder.didSucceed(nil)
                }
            case .failure(let error):
                let errorCode = (error as? URLError)?.code
                let statusCode = response.response?.statusCode
                
                var responseModel: Decodable?
                if errorCode == nil && responseJSON != nil {
                    responseModel = APIError.model(response.data!)
                }
                
                requestHolder.didFail(errorCode, statusCode, responseModel)
            }
        }
    
    return requestHolder
}

struct RequestHolder {
    let endPointName: EndPointName
    let didSucceed: (Decodable?) -> Void
    let didFail: (URLError.Code?, Int?, Decodable?) -> Void
}
