//
//  Book.h
//  Heroku
//
//  Created by Aswini Ramesh on 5/16/17.
//  Copyright © 2017 Aswini Ramesh. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Book:NSObject

@property (strong, nonatomic) NSString* author;
@property (strong, nonatomic) NSString* categories;
@property (nonatomic) NSInteger id;
@property (strong, nonatomic) NSString* lastCheckedOut;
@property (strong, nonatomic) NSString* lastCheckedOutBy;
@property (strong, nonatomic) NSString* publisher;
@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString* url;

@end
