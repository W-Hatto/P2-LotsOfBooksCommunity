public without sharing class FavoriteBook {

    @AuraEnabled
    public static List<Book__c> getFavoriteBooks() {
        String currentUserId = UserInfo.getUserId();
        User currentUser = [SELECT Id, ContactId FROM User WHERE Id=:currentUserId];
        
        //System.debug('UserID: ' + currentUser.Id + ' ContactId: ' + currentUser.ContactID);
            
        List<FavoritedBook__c> favoritedBookList = [SELECT Book__c FROM FavoritedBook__c WHERE (Contact__c = :currentUser.ContactId)];
        List<String> favoritedBookIds = new List<String>();
        for (FavoritedBook__c favBook : favoritedBookList) {
            favoritedBookIds.add(favBook.Book__c);
        }
        
        //System.debug('Favorite Book__c Ids: ' + favoritedBookIds);
        
        List<Book__c> favoriteBookList = [SELECT Id, ISBN__c, Authors__c, By_Statement__c, Cover_URL__c,
                                          Ebook_URL__c, Notes__c, Number_Of_Pages__c, Publish_Date__c,
                                          Publishers__c, Title__c, Subjects__c
                                          FROM Book__c WHERE (Id IN :favoritedBookIds)];
        
        //System.debug('FavoriteBookList size: ' + favoriteBookList.size());
        
        return favoriteBookList;
    }
    
    @AuraEnabled
    public static void addToFavorites(Book__c bookToFavorite) {
        Decimal bookISBN = bookToFavorite.ISBN__c;
		List<Book__c> favoriteBookList = getFavoriteBooks();
        
        System.debug('Size of favoriteBookList: ' + favoriteBookList.size());
        
        // Check to see if the book is already favorited
        for (Book__c favBook : favoriteBookList) {
            if (favBook.ISBN__c == bookISBN) {
                System.debug('This book is already favorited.');
                return;
            }
        }        

        System.debug('The book is not already favorited.');
        
        // If it isn't, create a new FavoriteBook record
        String currentUserId = UserInfo.getUserId();
        User currentUser = [SELECT Id, ContactId FROM User WHERE Id=:currentUserId];
        
        System.debug('UserID: ' + currentUser.Id + ' ContactId: ' + currentUser.ContactID);
        
        System.debug('bookToFavorite: ' + bookToFavorite);
        
        // Create a new book record only if one doesn't exist already.
        List<Book__c> preexistingVersions = [SELECT Id FROM Book__c WHERE (ISBN__c=:bookISBN)];
        if (preexistingVersions.size() == 0) {
            System.debug('Create new Book__c Record.');
            insert bookToFavorite;
            // Create a new FavoritedBook record.
            FavoritedBook__c newFavoriteBook = new FavoritedBook__c(Contact__c = currentUser.ContactId, Book__c = bookToFavorite.Id);
            insert newFavoriteBook;
        }
        else {
            System.debug('A Book__c Record with this ISBN already exists.');
            FavoritedBook__c newFavoriteBook = new FavoritedBook__c(Contact__c = currentUser.ContactId, Book__c = preexistingVersions[0].Id);
            insert newFavoriteBook;
        }
        
        

        
        try {

        } catch (Exception e) {
            System.debug(e.getStackTraceString());
        }
        
    }
    
}