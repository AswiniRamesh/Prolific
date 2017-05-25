//
//  ViewController.m
//  Heroku
//
//  Created by Aswini Ramesh on 5/15/17.
//  Copyright © 2017 Aswini Ramesh. All rights reserved.
//
#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bookTableView.delegate=self;
    self.bookTableView.dataSource=self;
    
    self.books = [[NSMutableArray alloc]init];
    [self getBooksFromServer];
    
    if(![self.bookTableView.subviews containsObject:self.refreshControl])
    {
        self.refreshControl = [[UIRefreshControl alloc]init];
        self.refreshControl.backgroundColor = [UIColor purpleColor];
        self.refreshControl.tintColor = [UIColor whiteColor];
        [self.bookTableView addSubview:self.refreshControl];
        [self.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    }
    self.bookTableView.allowsMultipleSelectionDuringEditing = NO;
    self.selectedRow = 0;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self getBooksFromServer];
    [super viewWillAppear:animated];
    [self.bookTableView layoutIfNeeded];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addBarButtonClicked:(id)sender
{
    
    [self performSegueWithIdentifier:ADD_BOOK_SEGUE sender:self];
}


- (IBAction)deleteAllBarButtonClicked:(id)sender
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:ALERT_TITLE  message:BOOK_DELETE_PROMPT preferredStyle:UIAlertControllerStyleAlert];
        
    UIAlertAction* ok = [UIAlertAction actionWithTitle:OK style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                       message:@""                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        
    [[BooksWebServices sharedInstance]  deleteAllBooks:^( NSError *error){
                
                if (error)
                {
                    
                    alert.message = BOOK_DELETE_ERROR_MESSAGE;
                    
                    [self presentViewController:alert animated:YES completion:nil];
                    return;
                    
                }
                
               [self refreshTable];
                
               alert.message = ALL_BOOKS_DELETED_MESSAGE;
               [self presentViewController:alert animated:YES completion:nil];
                
                int duration = 1;
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [alert dismissViewControllerAnimated:YES completion:nil];
                    
                });
                }];
      }];
    
        [alertController addAction:ok];
    
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:CANCEL style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    
}

- (void)getBooksFromServer
{
    
    [[BooksWebServices sharedInstance]  getBooksWebService:^(NSMutableArray *arr, NSError *error){
        
        if (self.refreshControl) {
        [self.refreshControl endRefreshing];
         }
        if (error)
        {
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                           message:BOOK_GET_ERROR_MESSAGE
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            [self presentViewController:alert animated:YES completion:nil];
            
            self.bookTableView.separatorStyle = UITableViewCellSelectionStyleNone;
            self.bookTableView.hidden =YES;
            self.emptyTableLabel.hidden =NO;
            return;
        }
        
         self.booksList=arr;
         [self parseBooks];

         if([self.booksList count]==0)
         {
             
             self.bookTableView.separatorStyle = UITableViewCellSelectionStyleNone;
             self.bookTableView.hidden =YES;
             self.emptyTableLabel.hidden =NO;

         }
         else
         {   self.bookTableView.separatorStyle = UITableViewCellSelectionStyleBlue;
             self.bookTableView.hidden =NO;
             self.emptyTableLabel.hidden =YES;
         }
    }];
}

- (void)deleteBookByBookID:(NSInteger) bookID
{
    [[BooksWebServices sharedInstance]  deleteBookWebServicebyID:bookID andCompletion:^(NSInteger bookID, NSError *error){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                       message:@""
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        if (error)
        {
            
            alert.message =BOOK_DELETE_ERROR_MESSAGE;
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
        
        [self refreshTable];
        
        alert.message = BOOK_DELETED_MESSAGE;
        [self presentViewController:alert animated:YES completion:nil];
        int duration = 1;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [alert dismissViewControllerAnimated:YES completion:nil];
            
        });
    
    }];
    
  }


-(void) refreshTable
{
    [self getBooksFromServer];
    if (self.refreshControl) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:REFERESH_DATE_FORMAT];
        NSString *title = [NSString stringWithFormat:@"Last update: %@", [formatter stringFromDate:[NSDate date]]];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                    forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        self.refreshControl.attributedTitle = attributedTitle;
        [self.refreshControl endRefreshing];
    }
}

- (void)parseBooks
{
    
    [self.books removeAllObjects];
    
    for(NSDictionary *dic in self.booksList)
    {
        
        Book * book = [[Book alloc]init];
        
        book.author = [dic objectForKey:@"author"];
        book.categories= [dic objectForKey:@"categories"];
        book.id = [[dic objectForKey:@"id"]integerValue];
        book.lastCheckedOut= [dic objectForKey:@"lastCheckedOut"];
        book.lastCheckedOutBy= [dic objectForKey:@"lastCheckedOutBy"];
        book.publisher = [dic objectForKey:@"publisher"];
        book.title = [dic objectForKey:@"title"];
        book.url = [dic objectForKey:@"url"];
        
        [self.books addObject:book];
    }
    [self.bookTableView reloadData];
    
}


#pragma addBookDelegate Methods

-(void) doneButtonPressed
{
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void) addBookToLibrary:(Book *)book
{
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    [self refreshTable];
   
}


#pragma TableView DataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.books count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
       
    static NSString *bookTableIdentifier = BOOK_TABLE_ID;
    
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                                    reuseIdentifier:bookTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:bookTableIdentifier];
    }
    Book *tableRowBook =[self.books objectAtIndex:indexPath.row];
    
    cell.textLabel.text = tableRowBook.title;
    cell.textLabel.numberOfLines=3;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    cell.detailTextLabel.text = tableRowBook.author;
    cell.detailTextLabel.numberOfLines=3;
    cell.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    return cell;
}

#pragma TableView Editing


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.row == self.selectedRow)
    {
        return UITableViewCellEditingStyleDelete;
    }
    else
    {
        return UITableViewCellEditingStyleNone;
    }
    
}
-(BOOL) tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (void)tableView: (UITableView *)tableView commitEditingStyle: (UITableViewCellEditingStyle)editingStyle forRowAtIndexPath: (NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
     {
     Book *bookAtIndex =[self.books objectAtIndex:indexPath.row];
     [self deleteBookByBookID:bookAtIndex.id];
     [self.books removeObjectAtIndex:[indexPath row]];
     [self.bookTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
     [self.bookTableView reloadData];
       
 }}
    
#pragma TableView Delegate Methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    self.selectedRow =indexPath.row;
    
   [self performSegueWithIdentifier:BOOK_DETAIL_SEGUE sender:self];
    
}
#pragma Prepare for Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
   
    if ([[segue identifier] isEqualToString:BOOK_DETAIL_SEGUE])
    {
        
        NSIndexPath *indexPath = [self.bookTableView indexPathForSelectedRow];
        Book *tableboo =[self.books objectAtIndex:indexPath.row];
        
        if ([segue.destinationViewController respondsToSelector:@selector(setBookData:)]) {
            [segue.destinationViewController performSelector:@selector(setBookData:)
                                                  withObject:tableboo];
        }
       
    }
    else if([[segue identifier] isEqualToString:ADD_BOOK_SEGUE])
    {
     
        if([segue.destinationViewController isKindOfClass:[AddBooksViewController class]])
        {
        AddBooksViewController *viewController =segue.destinationViewController;
        viewController.delegate = self;
        }
        
    }
}
@end