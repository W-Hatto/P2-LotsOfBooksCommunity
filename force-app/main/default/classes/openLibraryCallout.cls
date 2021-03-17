public without sharing class openLibraryCallout {
 
    // Note: This function can take in multiple ISBN values as
    // one string of comma-separated values, but the aura components are set
    // up to only send in either one ISBN-10 or one ISBN-13 as a String in 
    // the format ISBN:0000000000 or ISBN:0000000000000.
    @AuraEnabled
    public static List<Book__c> getBook(String isbn) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        // Known ISBNs: ISBN:0451526538,ISBN:0201558025
        request.setEndpoint('https://openlibrary.org/api/books?bibkeys=' + isbn + '&jscmd=data&format=json');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        
        List<Book__c> bookList = new List<Book__c>();
        if (response.getStatusCode() == 200) {
            String body = response.getBody();

            System.JSONParser parser = JSON.createParser(body);

            parser.nextToken();  
            while (parser.nextToken() != null) {
                if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
                    Book tempBook = (Book)parser.readValueAs(Book.class);
                    System.debug(JSON.serialize(tempBook));
                    
                    // Remove 'ISBN:' from the input string and convert the result
                    // to a number.
                    String isbnValue = isbn.remove('ISBN:');
                    Long numIsbn = Long.valueOf(isbnValue);
                    System.debug('ISBN value: ' + '|' + numIsbn + '|');
                    
                    Book__c currentBook = new Book__c(Title__c = tempBook.title,
                                                      By_Statement__c = tempBook.by_statement,
                                                      Cover_URL__c = tempBook.cover.medium,
                                                      Number_Of_Pages__c = tempBook.number_of_pages,
                                                      ISBN__c = (Decimal)numIsbn,
                                                      Notes__c = tempBook.notes,
                                                      Publish_Date__c = tempBook.publish_date,
                                                      Ebook_URL__c = tempBook.ebooks[0].preview_url
                                                      );
                    System.debug('Book instantiated successfully.');
                    bookList.add(currentBook);
                    parser.skipChildren();
                    parser.nextToken();
                }
            }
			
        }
    return bookList;
    }
}