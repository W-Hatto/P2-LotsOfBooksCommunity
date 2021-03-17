public without sharing class FavoriteBook {

    /* This class holds methods for dealing with FavoritedBook__c
     * objects */
    
    @AuraEnabled
    public static List<Book__c> getFavoriteBooks() {
        // Get the current User so the associated Contact Id can be accessed.
        String currentUserId = UserInfo.getUserId();
        User currentUser = [SELECT Id, ContactId FROM User WHERE Id=:currentUserId];
            
        // Find all Favorited Books that are associated with the current user's Contact Id.
        // Store the Book ids in a list.
        List<FavoritedBook__c> favoritedBookList = [SELECT Book__c FROM FavoritedBook__c WHERE (Contact__c = :currentUser.ContactId)];
        List<String> favoritedBookIds = new List<String>();
        for (FavoritedBook__c favBook : favoritedBookList) {
            favoritedBookIds.add(favBook.Book__c);
        }
        
        // Query for the Books using the list of ids, then return the list of books.
        List<Book__c> favoriteBookList = [SELECT Id, ISBN__c, Authors__c, By_Statement__c, Cover_URL__c,
                                          Ebook_URL__c, Notes__c, Number_Of_Pages__c, Publish_Date__c,
                                          Publishers__c, Title__c, Subjects__c
                                          FROM Book__c WHERE (Id IN :favoritedBookIds)];
        
        return favoriteBookList;
    }
    
    @AuraEnabled
    public static void addToFavorites(Book__c bookToFavorite) {
     
        // Get the list of Book__c objects you have favorited.
		List<Book__c> favoriteBookList = getFavoriteBooks();
        
        // Check to see if the book the user wants to favorite is already favorited.
        Decimal bookISBN = bookToFavorite.ISBN__c;
        for (Book__c favBook : favoriteBookList) {
            if (favBook.ISBN__c == bookISBN) {
                System.debug('This book is already favorited.');
                return;
            }
        }        
       
        // If the book isn't already favorited, create a new FavoriteBook record.
        // First, get the current User so we can access its Contact Id.
        String currentUserId = UserInfo.getUserId();
        User currentUser = [SELECT Id, ContactId FROM User WHERE Id=:currentUserId];
               
        // Create a new Book record if one doesn't exist already.
        List<Book__c> preexistingVersions = [SELECT Id FROM Book__c WHERE (ISBN__c=:bookISBN)];
        if (preexistingVersions.size() == 0) {
            // Save the Book to the database and associate its Id to a new FavoritedBook record.
            insert bookToFavorite;
            FavoritedBook__c newFavoriteBook = new FavoritedBook__c(Contact__c = currentUser.ContactId, Book__c = bookToFavorite.Id);
            insert newFavoriteBook;
        }
        else {
            // If the Book already exists, associate the existing book's Id to the new FavoritedBook record.
            FavoritedBook__c newFavoriteBook = new FavoritedBook__c(Contact__c = currentUser.ContactId, Book__c = preexistingVersions[0].Id);
            insert newFavoriteBook;
        }  
    }
    
}