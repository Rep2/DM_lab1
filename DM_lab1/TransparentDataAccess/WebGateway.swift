import RxSwift
import Unbox
import Alamofire
import RxAlamofire

class WebGateway {
    func getResource<Resource: Unboxable, Target: WebTarget>(_ resourceTarget: Target,
                     dispatchQueue: ConcurrentDispatchQueueScheduler = ConcurrentDispatchQueueScheduler(qos: .default)) -> Observable<Resource> {
        return
            requestData(resourceTarget.method, resourceTarget.url, parameters: resourceTarget.parameters, encoding: resourceTarget.encoding, headers: resourceTarget.headers)
                .observeOn(dispatchQueue)
                .flatMap ({ response -> Observable<Resource> in
                    return unboxData(data: response.1)
                })
    }

    func getResource<Resource: Unboxable, Target: WebTarget>(_ resourceTarget: Target,
                     dispatchQueue: ConcurrentDispatchQueueScheduler = ConcurrentDispatchQueueScheduler(qos: .default)) -> Observable<[Resource]> {
        return
            requestData(resourceTarget.method, resourceTarget.url, parameters: resourceTarget.parameters, encoding: resourceTarget.encoding, headers: resourceTarget.headers)
                .observeOn(dispatchQueue)
                .flatMap ({ response -> Observable<[Resource]> in
                    return unboxData(data: response.1)
                })
    }
}

func unboxData<R: Unboxable>(data: Data) -> Observable<R> {
    return Observable.create({ (observer) -> Disposable in
        do {
            let resource: R = try Unbox(data: data)

            observer.onNext(resource)
            observer.onCompleted()
        } catch {
            observer.onError(GatewayError.unboxingError)
        }

        return Disposables.create()
    })
}


func unboxData<R: Unboxable>(data: Data) -> Observable<[R]> {
    return Observable.create({ (observer) -> Disposable in
        do {
            let resource: [R] = try Unbox(data: data)

            observer.onNext(resource)
            observer.onCompleted()
        } catch {
            observer.onError(GatewayError.unboxingError)
        }

        return Disposables.create()
    })
}
