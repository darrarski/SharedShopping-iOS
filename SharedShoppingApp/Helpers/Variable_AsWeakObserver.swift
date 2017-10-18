import RxSwift

extension Variable {

    func asWeakObserver() -> AnyObserver<Element> {
        return AnyObserver(eventHandler: { [weak self] event in
            switch event {
            case .next(let element): self?.value = element
            case .completed, .error: return
            }
        })
    }

}
