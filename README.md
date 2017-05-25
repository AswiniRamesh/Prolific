# Prolific
Library Application for Prolific Interactive 


###Application Functionality

	•	List the books obtained from the server  is displayed .

	•	Delete all books action is supported .

	•	Add book action which takes book title,author,categories and publisher details from user is supported.After adding the book details to server,the app will return back to display screen.

	•	Each tableview cell which displays book details can be swiped right to delete individual books.

	•	Selecting a book in the display will take the user to detailed view of books

	•	From the detailed view of books, user can checkout the book.Upon clicking checkout button user can enter his/her name which will be updated in the server along with the timestamp.After checking out the app will return back to display screen.

	•	From the detailed view of books, user can also share the information about the book to social media.

	•	GET,PUT,POST and DELETE is used along with the REST API endpoint mentioned in the requirements.


	
### Wireframes used

	•	Same as those given in the specification
	•	Design principle was to make the application simple,neat and minimalistic.So no external libraries,images or styling is used in this app

###Libraries used:

	•	AFNetworking - for handling web services

	•	PS:Cocoapods was not used.AFNetworking library files was directly integrated into the application.This was because I am using a VM player on top of a  Windows PC and hence it was not possible to setup and install pod due to speed issues of the machine.


###Design Considerations

	•	MVC architecture to ensure modularity and scalability

	•	A singleton class BookWebServices is used to handle web services so that data is shared among different parts of code rather than doing it manually.

	•	Delegate is used for proper communication between add books screen and display screen.

	•	Prototype cells are used to create custom tableview cells.Since the date to be displayed is basic the capabilities of custom cell was not used, but this will be handy in a situation where the app is to be scaled.

	•	Cell editing functions modified to do single cell delete.

	•	External images,styling gradients etc were not used as the design principle was to make the app simple and minimalistic.

	•	Since the JSON data was structurally simple no libraries was used for parsing.In case of complex JSON structures, JSONModel library  can be used

###Device Family Supported

	•	iPhone 4+

###Build Requirements

	•	Xcode 7.0 or later

###Runtime Requirements

	•	iOS 8+

###Further Improvements:

	•	JSONModel library  can be used

	•	Offline mode feature can be introduced.



￼










