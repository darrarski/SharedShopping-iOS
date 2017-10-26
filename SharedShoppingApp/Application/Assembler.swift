import Swinject

extension Assembler {

    static var `default`: Assembler {
        return Assembler([
            AppAssembly(),
            ShoppingsAssembly()
        ])
    }

}
