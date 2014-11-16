Class {
	#name : #LibraryRestClient,
	#superclass : #Object,
	#category : #'Teapot-Library-Example'
}

{ #category : #library }
LibraryRestClient >> addBook: aDictionary [
	ZnClient new
		url: self baseUrl, '/books';
		formAt: 'title' put:  (aDictionary at: #title);
		formAt: 'authors' put: (aDictionary at: #authors);
		post
]

{ #category : #private }
LibraryRestClient >> baseUrl [
	^ 'http://localhost:', self port asString
]

{ #category : #library }
LibraryRestClient >> findAll [
	| response |
	response := ZnClient new
		url: self baseUrl, '/books';
		get.		
	^ NeoJSONReader fromString: response


]

{ #category : #library }
LibraryRestClient >> findBook: bookId [
	| response |
	response := ZnClient new
		url: self baseUrl, '/books/', bookId asString;
		get.
	^ NeoJSONReader fromString: response
]

{ #category : #private }
LibraryRestClient >> port [
	^ 8000
]

{ #category : #library }
LibraryRestClient >> removeBook: bookId [
	^ ZnClient new
		url: self baseUrl, '/books/', bookId asString;
		delete


]

{ #category : #library }
LibraryRestClient >> replaceBook: bookId with: aDictionary [
	ZnClient new
		url: self baseUrl, '/books/', bookId asString;
		formAt: 'title' put:  (aDictionary at: #title);
		formAt: 'authors' put: (aDictionary at: #authors);
		put
]
