//
//  BooksDetailViewController.h
//  Heroku
//
//  Created by Aswini Ramesh on 5/17/17.
//  Copyright © 2017 Aswini Ramesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"
#import "BooksWebServices.h"
#import "HerokuDefines.h"

@interface BooksDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *checkOutButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *publisherLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *shareButton;
@property (weak, nonatomic) IBOutlet UILabel *tagsLabel;
@property (weak, nonatomic) IBOutlet UILabel *checkedOutLabel;
@property (strong, nonatomic) Book *currentBook;


- (IBAction) shareAction:(id)sender;
- (IBAction) checkOutButtonPressed:(id)sender;

- (void) setBookData:(Book*) book;
- (void) displayBookDetails;
- (void) updateDataWithUserName:(NSString*) username;

@end
