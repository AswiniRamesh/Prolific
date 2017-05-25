//
//  BooksDetailViewController.m
//  Heroku
//
//  Created by Aswini Ramesh on 5/17/17.
//  Copyright © 2017 Aswini Ramesh. All rights reserved.
//

#import "BooksDetailViewController.h"

@interface BooksDetailViewController ()

@end

@implementation BooksDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self displayBookDetails];
    
   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}
- (IBAction)checkOutButtonPressed:(id)sender
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:ALERT_TITLE message:CHECKOUT_BUTTON_PROMPT preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder =ENTER_NAME_PROMPT;
        
    }];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:OK style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self updateDataWithUserName:[[alertController textFields][0] text]];
        
           }];
    [alertController addAction:confirmAction];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:CANCEL style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
       
    }];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)shareAction:(id)sender
{
    NSString *shareString = [NSString stringWithFormat: @"Check out this book - %@ by %@  from prolific library", self.currentBook.title,self.currentBook.author];
    NSArray* sharedObjects=[NSArray arrayWithObjects:shareString,  nil];
    
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc]                                                                initWithActivityItems:sharedObjects applicationActivities:nil];
    activityViewController.popoverPresentationController.sourceView = self.view;
    [self presentViewController:activityViewController animated:YES completion:nil];
    
}


-(void) displayBookDetails
{
    self.titleLabel.text= self.currentBook.title;
    self.authorLabel.text= self.currentBook.author;
    self.publisherLabel.text = [NSString stringWithFormat: @"Publisher:  %@",self.currentBook.publisher];
    self.tagsLabel.text=[NSString stringWithFormat: @"Tags:  %@",self.currentBook.categories];
    
    NSLog(@"last checked%@",self.currentBook.lastCheckedOut);
    
    if( (self.currentBook.lastCheckedOutBy == (id)[NSNull null]) || (self.currentBook.lastCheckedOut == (id)[NSNull null] ))
    {
        self.checkedOutLabel.text = LAST_CHECKED_NO_INFO;
    }
    else
    {
       
        NSString *dateString = self.currentBook.lastCheckedOut;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        [dateFormatter setFormatterBehavior:NSDateFormatterBehaviorDefault];
        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
        [dateFormatter setLocale:[NSLocale currentLocale]];
        NSDate *date = [dateFormatter dateFromString:dateString];
        [dateFormatter setDateFormat:@"MMM dd, yyyy h:mm:ss aaa"];
        NSString *updatedString = [dateFormatter stringFromDate:date];
        
        self.checkedOutLabel.text = [NSString stringWithFormat: @"LastCheckedOutBy:  %@ @ %@", self.currentBook.lastCheckedOutBy,updatedString];
    }
}


-(void) setBookData:(Book*) book{
    
    self.currentBook = book;
    
}

-(void)updateDataWithUserName:(NSString *)username
{
    
    NSDateFormatter* bookDateFormat = [[NSDateFormatter alloc] init];
    [bookDateFormat setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString* dateString = [bookDateFormat stringFromDate:[NSDate date]];
    
   
    [[BooksWebServices sharedInstance]  putBooks:username andDate:dateString andBookID:self.currentBook.id andCompletion:^(NSMutableArray *arr, NSError *error){
        if (error)
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                           message:BOOK_UPDATE_ERROR_MESSAGE
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            [self presentViewController:alert animated:YES completion:nil];
            

            return;
        }
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                       message:BOOK_CHECKED                                                                preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
        int duration = 1; // duration in seconds
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            
            [alert dismissViewControllerAnimated:YES completion:nil];
            
            [self.navigationController popViewControllerAnimated:YES];
        });
        
    }];
    
   }


@end

