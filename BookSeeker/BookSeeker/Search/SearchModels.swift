struct SearchModels {
    struct Book {
        let name: String
        let thumbArtworkUrl: String
    }
    
    enum SearchBook {
        struct Request {
            let term: String
        }
        
        enum Success {
            struct Response {
                let books: [Book]
            }
            
            struct ViewModel {
                let books: [Book]
            }
        }
        
        enum Failure {
            struct Response {
                let error: Error
            }
            
            struct ViewModel {
                let errorMessage: String
            }
        }
    }
    
    enum SearchHistory {
        struct Request {}
        
        struct Response {
            let terms: [String]
        }
        
        struct ViewModel {
            let terms: [String]
        }
    }
}
