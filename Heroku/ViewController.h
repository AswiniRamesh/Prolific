//
//  ViewController.h
//  Heroku
//
//  Created by Aswini Ramesh on 5/15/17.
//  Copyright © 2017 Aswini Ramesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"
#import "AddBooksViewController.h"
#import "BooksDetailViewController.h"
#import "BooksTableCell.h"
#import "BooksWebServices.h"
#import "HerokuDefines.h"


@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,addBookDelegate>

@property (weak, nonatomic) IBOutlet UITableView *bookTableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addBarButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *deleteAllBarButtonItem;
@property (weak, nonatomic) IBOutlet UILabel *emptyTableLabel;
@property (strong, nonatomic) NSMutableArray *booksList;
@property (strong, nonatomic) NSMutableArray *books;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (nonatomic) NSInteger selectedRow;

- (IBAction) deleteAllBarButtonClicked:(id)sender;
- (IBAction) addBarButtonClicked:(id)sender;

- (void) deleteBookByBookID:(NSInteger)bookID;
- (void) parseBooks;
- (void) getBooksFromServer;
- (void) refreshTable;

@end

