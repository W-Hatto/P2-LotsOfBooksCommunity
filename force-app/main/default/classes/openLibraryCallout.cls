public without sharing class openLibraryCallout {
    //public static List<Book> getBook(String bibkeys) {
    @AuraEnabled
    public static List<Book__c> getBook(String bibkeys) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        // For testing: bibkeys=ISBN:0451526538,ISBN:0201558025
        request.setEndpoint('https://openlibrary.org/api/books?bibkeys=' + bibkeys + '&jscmd=data&format=json');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        
        //List<Book> bookList = new List<Book>();
        List<Book__c> bookList = new List<Book__c>();
        if (response.getStatusCode() == 200) {
            String body = response.getBody();

            System.JSONParser parser = JSON.createParser(body);

            parser.nextToken();  
            while (parser.nextToken() != null) {
                if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
                    Book tempBook = (Book)parser.readValueAs(Book.class);
                    //bookList.add(tempBook);
                    //System.debug(tempBook);
                    System.debug(JSON.serialize(tempBook));
                    
                    //System.debug(tempBook.ebooks);
                    System.debug(tempBook.authors);
                    //System.debug(tempBook.by_statement);
                    //System.debug(tempBook.cover);
                    System.debug(tempBook.subjects);
                    System.debug(tempBook.cover.medium);
                    //System.debug(tempBook.notes);
					
                    Book__c currentBook = new Book__c(Title__c = tempBook.title,
                                                      By_Statement__c = tempBook.by_statement,
                                                      Cover_URL__c = tempBook.cover.medium,
                                                      Number_Of_Pages__c = tempBook.number_of_pages,
                                                      ISBN__c = tempBook.identifiers.isbn_10[0],
                                                      Notes__c = tempBook.notes,
                                                      Publish_Date__c = tempBook.publish_date
                                                      );
                    bookList.add(currentBook);
                    parser.skipChildren();
                    parser.nextToken();
                }
            }
			
        }
    return bookList;
    }
}

/* ORIGINAL CODE:
    if (response.getStatusCode() == 200) {
    String body = response.getBody();
    //Map<String, String> bodyMap = (Map<String,String>) JSON.deserializeUntyped(body);
    //System.debug(bodyMap);
    System.JSONParser parser = JSON.createParser(body);
    
    // The response starts with JSONTOKEN.START_OBJECT an can hold multiple books
    //Map<String, Book> bookMap = new Map<String, Book>();
    List<Book> bookList = new List<Book>();
    parser.nextToken();                             //NOT A PERMANENT SOLUTION
    while (parser.nextToken() != null) {
    System.debug(parser.getCurrentToken());
    
    if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
    
    //System.debug(parser.getCurrentToken());
    Book currentBook = (Book)parser.readValueAs(Book.class);
    bookList.add(currentBook);
    System.debug(JSON.serialize(currentBook));
    System.debug(currentBook.authors);
    System.debug(currentBook.by_statement);
    System.debug(currentBook.cover);
    System.debug(currentBook.subjects);
    System.debug(currentBook.notes);
    parser.skipChildren();
*/