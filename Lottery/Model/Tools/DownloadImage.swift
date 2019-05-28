import UIKit
import Kingfisher

extension UIImageView {
    @discardableResult
    func downloadImageFrom(_ url: String, didSucceed: ((UIImage) -> Void)? = nil) -> DownloadTask? {
        let debuggingIsEnabled = Settings.model().debuggingIsEnabled
        
        if debuggingIsEnabled {
            print("Downloading image from \(url)...")
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        return kf.setImage(with: URL(string: url)!, placeholder: nil, options: nil, progressBlock: nil) { result in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            switch result {
            case .success(let retrieveResult):
                if debuggingIsEnabled {
                    let downloadSource: String
                    switch retrieveResult.cacheType {
                    case .none:
                        downloadSource = "network"
                    case .disk:
                        downloadSource = "disk"
                    case .memory:
                        downloadSource = "memory"
                    }
                    
                    print("Image of \(url) downloaded from \(downloadSource).")
                }
                
                if let didSucceed = didSucceed {
                    didSucceed(retrieveResult.image)
                }
            case .failure(let error):
                if debuggingIsEnabled {
                    print("Image of \(url) did not download because of \(error.failureReason!).")
                }
            }
        }
    }
}
