//
//  AddBooksViewController.h
//  Heroku
//
//  Created by Aswini Ramesh on 5/16/17.
//  Copyright © 2017 Aswini Ramesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"
#import "BooksWebServices.h"
#import "HerokuDefines.h"

@protocol addBookDelegate <NSObject>

@required

-(void) doneButtonPressed;
-(void) addBookToLibrary:(Book*) book;

@end

@interface AddBooksViewController : UIViewController

@property(weak,nonatomic) id <addBookDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *authorTextField;
@property (weak, nonatomic) IBOutlet UITextField *publisherTextField;
@property (weak, nonatomic) IBOutlet UITextField *categoriesTextField;


- (IBAction)doneButtonPressed:(id)sender;
- (IBAction)submitButtonPressed:(id)sender;

- (void)postBooksToServer:(Book*) book;


@end
