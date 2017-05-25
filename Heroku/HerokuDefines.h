//
//  HerokuDefines.h
//  Heroku
//
//  Created by Aswini Ramesh on 5/19/17.
//  Copyright © 2017 Aswini Ramesh. All rights reserved.
//

#ifndef HerokuDefines_h
#define HerokuDefines_h

#define ALERT_TITLE @"Heroku"
#define BOOK_DELETED_MESSAGE @"Book Deleted"
#define ALL_BOOKS_DELETED_MESSAGE @" All Books Deleted"
#define BOOK_CHECKED @"Book checked out Successfully"

#define REFERESH_DATE_FORMAT @"MMM d, h:mm a"

#define BOOK_DELETE_ERROR_MESSAGE @"An error occured wHile deleting book.Try Again"
#define BOOK_GET_ERROR_MESSAGE @"An error occured wHile getting book from server.Try Again"
#define BOOK_UPDATE_ERROR_MESSAGE @"An error occured wHile updating book.Try Again"
#define BOOK_POST_ERROR_MESSAGE @"An error occured wHile adding book.Try Again"

#define BOOK_DELETE_PROMPT @"All Books will be deleted.Do you still want to proceed"
#define DONE_BUTTON_PROMPT @"Your changes will not be saved.Do you still want to proceed"
#define SUBMIT_BUTTON_PROMPT @"Please fill all blank fields"
#define CHECKOUT_BUTTON_PROMPT @"Please Enter your name"
#define ENTER_NAME_PROMPT @"Enter your name here";

#define CANCEL @"Cancel"
#define OK @"OK"
#define BLANK_STRING @""

#define ADD_BOOK_SEGUE @"AddBookSegue"
#define BOOK_DETAIL_SEGUE @"BookDetailSegue"
#define BOOK_TABLE_ID @"BookIdentifier"

#define PUBLISHER @"Publisher: "
#define TAGS @"Tags: "
#define LAST_CHECKED @"LastCheckedOutBy: "
#define LAST_CHECKED_NO_INFO @"LastCheckedOutBy:  No information available"

#define BASE_URL @"http://prolific-interview.herokuapp.com/5917d67586255d000a137449/books"
#define SERVER_URL @"http://prolific-interview.herokuapp.com/5917d67586255d000a137449/books/"
#define DELETE_ALL_URL @"http://prolific-interview.herokuapp.com/5917d67586255d000a137449/clean"
#endif /* HerokuDefines_h */
