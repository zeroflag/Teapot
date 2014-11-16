Class {
	#name : #LibraryServerTest,
	#superclass : #TestCase,
	#instVars : [
		'client',
		'server',
		'book1',
		'book2'
	],
	#category : #'Teapot-Library-Example'
}

{ #category : #running }
LibraryServerTest >> setUp [ 
	client := LibraryRestClient new.
	server := LibraryServer serveOn: 8000.
	book1 := {#title -> 'book 1'. #authors -> 'author 1'} asDictionary.
	book2 := {#title -> 'book 2'. #authors -> 'author 2'} asDictionary.	
]

{ #category : #running }
LibraryServerTest >> tearDown [
	server stop
]

{ #category : #tests }
LibraryServerTest >> testDeletingBook [
	| books |
	books := client 
		addBook: book1;
		addBook: book2;
		removeBook: 2;
		findAll.	
	self assert: books size equals: 1.
	
	
]

{ #category : #tests }
LibraryServerTest >> testFindingAllBooks [
	| books |
	books := client 
		addBook: book1;
		addBook: book2;
		findAll.
	self assert: books size equals: 2.
	
	
]

{ #category : #tests }
LibraryServerTest >> testFindingBookById [
	| found id |
	id := client addBook: book1.
	found := client findBook: 1.
	self assert: found equals: (book1 copyWith: #id -> 1).
]

{ #category : #tests }
LibraryServerTest >> testUpdatingBook [
	| book |
	book := client 
		addBook: book1;
		replaceBook: 1 with: book2;
		findBook: 1.	
	self assert: book equals: (book2 copyWith: #id -> 1).
	
	
]
