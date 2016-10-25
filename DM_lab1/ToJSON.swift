protocol JSONable {
    func toJSON() -> [String : Any]
}

extension JSONable {
    func toJSON() -> [String : Any] {
        var retDict = [String : Any]()

        Mirror(reflecting: self)
            .children
            .map { child -> (String, Any) in
                return (child.label ?? "", "\(child.value)")
            }.forEach {
                retDict[$0.0] = $0.1
        }

        return retDict
    }
}
