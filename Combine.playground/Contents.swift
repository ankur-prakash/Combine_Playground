import UIKit
import Combine

var store = Set<AnyCancellable>()

var currentValueSubject = CurrentValueSubject<Bool, Never>(true)
let future = Future<Bool, Error> { promise in
    promise(.success(true))
}

print("Hello")
future
    .sink { completion in
        print("Future completion")

    } receiveValue: { value in
        print("Future value = \(value)")
    }
    .store(in: &store)


currentValueSubject
    .first()
    .flatMap { _ in
        Future<Bool, Error> { promise in
            promise(.success(false))
        }
    }.sink { completion in
        print("Future completion")

    } receiveValue: { value in
        print("Future value = \(value)")
    }.store(in: &store)

