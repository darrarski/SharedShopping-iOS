struct AlertActionViewModel {
    enum Style {
        case confirm
        case cancel
        case destruct
    }

    let title: String
    let style: Style
    let handler: () -> Void
}
