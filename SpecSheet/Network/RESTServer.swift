////
////  RESTServer.swift
////  Excalibur
////
////  Created by Michael Wells on 12/2/22.
////
//
//import Foundation
//
//final class RESTServer: Server {
//
//    private(set) var environment: AppEnvironment = .production
//    
//    func setEnvironment(_ environment: AppEnvironment) {
//        self.environment = environment
//    }
//
//    func request(
//        service: ServiceService,
//        modifiers: [any ServerRequestModifier]
//    ) -> HTTPRequestBuilder {
//        var urlPrefix: String
//        switch service {
//        case .api:
//            switch environment {
//            case .development:
//                urlPrefix = "https://api-dev.fishbowlonline.com/v1"
//            case .staging:
//                urlPrefix = "https://api-stag.fishbowlonline.com/v1"
//            case .production:
//                urlPrefix = "https://api.fishbowlonline.com/v1"
//            }
//        case .image:
//            switch environment {
//            case .development:
//                // TODO: This url is guessed - if you try and use it check it's validity first.
//                urlPrefix = "https://imageservice-dev.fishbowlonline.com"
//            case .staging:
//                urlPrefix = "https://imageservice-stag.fishbowlonline.com"
//            case .production:
//                urlPrefix = "https://imageservice.fishbowlonline.com"
//            }
//        }
//
//        var builder = HTTPRequestBuilder(urlPrefix: urlPrefix)
//
//        for modifier in modifiers {
//            builder = modifier.apply(builder)
//        }
//
//        return builder
//    }
//
//}
//
//extension Server {
//
//    func imageURL(to path: String, size: ServerImageSize) -> URL? {
//        var urlString = ""
//
//        switch environment {
//        case .development:
//            // TODO: This url is guessed - if you try and use it check it's validity first.
//            urlString.append("https://imageservice-dev.fishbowlonline.com")
//        case .staging:
//            urlString.append("https://imageservice-stag.fishbowlonline.com")
//        case .production:
//            urlString.append("https://imageservice.fishbowlonline.com")
//        }
//
//        urlString.append(path)
//
//        switch size {
//        case .small:
//            urlString.append("?size=small")
//        case .medium:
//            urlString.append("?size=medium")
//        case .large:
//            break
//        }
//
//        return URL(string: urlString)
//    }
//
//}
