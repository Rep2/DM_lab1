class CouchbaseGateway {

    static let instance = CouchbaseGateway()

    let database: CBLDatabase

    let document: CBLDocument

    init() {
        do {
            database = try CBLManager.sharedInstance().databaseNamed("couchbaseevents")

            document = database.createDocument()
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }

}
