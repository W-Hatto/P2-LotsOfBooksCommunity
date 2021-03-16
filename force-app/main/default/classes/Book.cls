public class Book {
    
    //String url;
    //String key;
    public String title {get; private set;}
    public List<detailObject> authors {get; private set;}
    public Integer number_of_pages {get; private set;}
    public String pagination {get; private set;}
    public String by_statement {get; private set;}
    public Identifier identifiers {get; private set;}
    //public Classification classifications {get; private set;}
    public List<publisher> publishers {get; private set;}
    //public List<publish_place> publish_places {get; private set;}
    public String publish_date {get; private set;}
    public List<detailObject> subjects {get; private set;}
    public List<detailObject> subject_places {get; private set;}
    public List<detailObject> subject_people {get; private set;}
    public List<detailObject> subject_times {get; private set;}
    public String notes {get; private set;}
    public covers cover {get; private set;}
    public List<ebook> ebooks {get; private set;}
    
    public Book (/*String url,*/
                 /*String key,*/
                 String title,
                 List<detailObject> authors,
                 Integer number_of_pages,
                 String pagination,
                 String by_statement,
                 Identifier identifiers,
                 /*Classification classifications,*/
                 List<publisher> publishers,
                 /*List<publish_place> publish_places,*/
        		 String publish_date,
                 List<detailObject> subjects,
                 List<detailObject> subject_places,
                 List<detailObject> subject_people,
                 List<detailObject> subject_times,
                 String notes,
                 covers cover,
                 List<ebook> ebooks) {
		//this.url = url;
		//this.key = key;
		this.title = title;
		this.authors = authors;
		this.number_of_pages = number_of_pages;
		this.pagination = pagination;
		this.by_statement = by_statement;
		this.identifiers = identifiers;
		//this.classifications = classifications;
		this.publishers = publishers;
		//this.publish_places = publish_places;
		this.publish_date = publish_date;
		this.subjects = subjects;
		this.subject_places = subject_places;
		this.subject_people = subject_people;
		this.subject_times = subject_times;
		this.notes = notes;
		this.cover = cover;
		this.ebooks = ebooks;        
    }
    
    // This book class is used for Callouts to the Open Library API.
    // The formatting of the List
    public List<String> getSimpleNameList(List<sObject> complexList) {
        return null;
    }
    
    // The JSON is formatted in such a way that each (type of) subject 
    // and each author has a url as well as a name. For the JSON to be
    // parsed properly, this inner class (and the other inner classes)
    // were created.
    public class detailObject {
    	public String url {get; private set;}
        public String name {get; private set;}
    }
        
    public class author {
        //String url;
        public String name {get; private set;}
    }

    public class identifier {
        public List<String> librarything {get; private set;}
        public List<String> project_gutenberg {get; private set;}
        public List<String> goodreads {get; private set;}
        public List<Integer> isbn_10 {get; private set;}
        public List<String> lccn {get; private set;}
        public List<String> oclc {get; private set;}
        public List<String> openlibrary {get; private set;}
    }

    public class classification {
        public List<String> lc_classifications {get; private set;}
        public List<String> dewey_decimal_class {get; private set;}
    }

    public class publisher {
        public String name {get; private set;}
    }

    public class publish_place {
        public String name {get; private set;}
    }

    public class subject {
        public String name {get; private set;}
        //String url;
    }

    public class covers {
        public String small {get; private set;}
        public String medium {get; private set;}
        public String large {get; private set;}
    }
    
    public class ebook {
        public String preview_url {get; private set;}
        public String availability {get; private set;}
    }
}