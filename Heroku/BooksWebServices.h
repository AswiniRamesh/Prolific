//
//  BooksWebServices.h
//  Heroku
//
//  Created by Aswini Ramesh on 5/18/17.
//  Copyright © 2017 Aswini Ramesh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "Book.h"
#import "HerokuDefines.h"

@interface BooksWebServices : NSObject


+ (BooksWebServices *)sharedInstance;


- (void)getBooksWebService:(void(^)(NSMutableArray *arr, NSError *error))completion;

- (void)deleteBookWebServicebyID:(NSInteger) bookID andCompletion:(void(^)(NSInteger bookID, NSError *error))completion;

- (void)postBooks:(Book*) book andCompletion:(void(^)(NSMutableArray *arr, NSError *error))completion;

- (void)putBooks:(NSString*) userName andDate:(NSString*)date andBookID :(NSInteger) bookID andCompletion:(void(^)(NSMutableArray *arr, NSError *error))completion;

- (void)deleteAllBooks:(void(^)(NSError *error))completion;

@end
