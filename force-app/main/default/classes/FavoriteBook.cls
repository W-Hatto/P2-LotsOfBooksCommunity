public without sharing class FavoriteBook {

    @AuraEnabled
    public static List<Book__c> getFavoriteBooks() {
        String currentUserId = UserInfo.getUserId();
        User currentUser = [SELECT Id, ContactId FROM User WHERE Id=:currentUserId];
        List<FavoritedBook__c> favoritedBookList = [SELECT Book__c FROM FavoritedBook__c WHERE (Contact__c = :currentUser.ContactId)];
        List<String> favoritedBookIds = new List<String>();
        for (FavoritedBook__c favBook : favoritedBookList) {
            favoritedBookIds.add(favBook.Book__c);
        }
        List<Book__c> favoriteBookList = [SELECT Id FROM Book__c WHERE (Id IN :favoritedBookIds)];
        return favoriteBookList;
    }
    
    @AuraEnabled
    public static void addToFavorites(Book__c bookToFavorite) {
        Decimal bookISBN = bookToFavorite.ISBN__c;
		List<Book__c> favoriteBookList = getFavoriteBooks();
        
        // Check to see if the book is already favorited
        for (Book__c favBook : favoriteBookList) {
            if (favBook.ISBN__c == bookISBN) {
                System.debug('This book is already favorited.');
                return;
            }
        }        

        // If it isn't, create a new FavoriteBook record
        String currentUserId = UserInfo.getUserId();
        User currentUser = [SELECT Id, ContactId FROM User WHERE Id=:currentUserId];
        List<Book__c> currentBook = [SELECT Id FROM Book__c WHERE (ISBN__c=:bookISBN)];
        
        // Create a new book record
        insert bookToFavorite;
        
        // 
		FavoritedBook__c newFavoriteBook = new FavoritedBook__c(Contact__c = currentUser.ContactId, Book__c = bookToFavorite.Id);
        insert newFavoriteBook;
        
    }
    
}