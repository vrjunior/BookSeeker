import Alamofire

struct BookSearchRequest: ItunesRequest {
    let path: String = "/search"
    
    let method: HTTPMethod = .get
    
    let encoding: ParameterEncoding = URLEncoding.default
    
    var parameters: Parameters? {
        return [
            "term": term,
            "entity": entity
        ]
    }
    
    private let term: String
    private let entity: String = "ibook"
    
    init(term: String) {
        self.term = term
    }
}
