//
//  AccessTokenService.swift
//  MoyaRefreshToken
//
//  Created by Josscii on 2019/7/15.
//  Copyright © 2019 Josscii. All rights reserved.
//

import RxSwift
import Moya

var accessToken = "initial-token"

class AccessTokenService {
    
    static let shared = AccessTokenService()
    private let bag = DisposeBag()
    let refreshToken = PublishSubject<Void>()
    let refreshTokenResult: Single<Response>
    
    init() {
        let provider = MoyaProvider<MyService>()
        refreshTokenResult = refreshToken
            .flatMapFirst { provider.rx.request(.accessToken) }
            .share(replay: 1)
            .asSingle()
        
        refreshTokenResult
            .subscribe(onSuccess: { _ in
                accessToken = "new-token"
            })
            .disposed(by: bag)
    }
}

extension Reactive where Base: MoyaProviderType {
    func requestWithTokenAutoRefresh(_ token: Base.Target, callbackQueue: DispatchQueue? = nil) -> Single<Response> {
        return request(token, callbackQueue: callbackQueue)
            .retryWhen {
                $0.flatMap { e -> Single<Response> in
                    if case let .statusCode(response)? = e as? MoyaError {
                        if response.statusCode == 401 {
                            defer {
                                AccessTokenService.shared.refreshToken.onNext(())
                            }
                            return AccessTokenService.shared.refreshTokenResult
                        }
                    }
                    
                    return Single.error(e)
                }
        }
    }
}
