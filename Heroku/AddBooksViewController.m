//
//  AddBooksViewController.m
//  Heroku
//
//  Created by Aswini Ramesh on 5/16/17.
//  Copyright © 2017 Aswini Ramesh. All rights reserved.
//

#import "AddBooksViewController.h"

@interface AddBooksViewController ()

@end

@implementation AddBooksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


- (IBAction)doneButtonPressed:(id)sender
{
   
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:ALERT_TITLE message:DONE_BUTTON_PROMPT preferredStyle:UIAlertControllerStyleAlert];
        
    UIAlertAction* ok = [UIAlertAction actionWithTitle:OK style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if ([self.delegate respondsToSelector:@selector(doneButtonPressed)])
                [self.delegate doneButtonPressed];
            
        }];
    [alertController addAction:ok];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:CANCEL style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    }];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (IBAction)submitButtonPressed:(id)sender
{
    
    if([self.titleTextField.text isEqualToString:BLANK_STRING] ||[self.authorTextField.text isEqualToString:BLANK_STRING]||[self.categoriesTextField.text isEqualToString:BLANK_STRING]||[self.publisherTextField.text isEqualToString:BLANK_STRING])
    {
         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:ALERT_TITLE message:SUBMIT_BUTTON_PROMPT preferredStyle:UIAlertControllerStyleAlert];
            
         UIAlertAction* ok = [UIAlertAction actionWithTitle:OK style:UIAlertActionStyleDefault handler:nil];
         [alertController addAction:ok];
            
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
    Book * book = [[Book alloc]init];
    book.author = self.authorTextField.text;
    book.categories= self.categoriesTextField.text;
    book.publisher = self.publisherTextField.text;
    book.title = self.titleTextField.text;
    
    [self postBooksToServer:book];
    if ([self.delegate respondsToSelector:@selector(addBookToLibrary:)])
        [self.delegate addBookToLibrary:book];
    
    }
}

- (void)postBooksToServer:(Book*) book
{
    [[BooksWebServices sharedInstance]  postBooks:book andCompletion:^(NSMutableArray *arr, NSError *error){
        
        if (error)
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                           message:BOOK_POST_ERROR_MESSAGE                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            [self presentViewController:alert animated:YES completion:nil];
            return;
            
        }
        
    }];
 
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField {
    [textField resignFirstResponder];
    return YES;
}


@end
