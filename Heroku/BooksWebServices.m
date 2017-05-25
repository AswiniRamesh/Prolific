//
//  BooksWebServices.m
//  Heroku
//
//  Created by Aswini Ramesh on 5/18/17.
//  Copyright © 2017 Aswini Ramesh. All rights reserved.
//

#import "BooksWebServices.h"

@implementation BooksWebServices

+ (instancetype)sharedInstance
{
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[[self class] alloc] init];
        
    });
    
    
    return _sharedInstance;
}


- (void)getBooksWebService:(void(^)(NSMutableArray *arr, NSError *error))completion
{
    
   AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:BASE_URL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
    {
        NSError *error = nil;
        NSMutableArray *arr = (NSMutableArray*)responseObject;
        
        if (!error)
            completion(arr, nil);
        else
            completion(nil, error);
        
     
                
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
            if (completion)
            completion(nil, error);
        
    }];
}
- (void)deleteBookWebServicebyID:(NSInteger) bookID andCompletion:(void(^)(NSInteger bookID, NSError *error))completion

{
    ;
    NSString *bookIdString = [SERVER_URL stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)bookID]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    
    [manager DELETE:bookIdString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSError *error = nil;
        
        if (!error)
            completion(bookID, nil);
        else
            completion(0, error);
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (completion)
            completion(0, error);
        
    }];

    
}

- (void)deleteAllBooks:(void(^)(NSError *error))completion
{
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    
    [manager DELETE:DELETE_ALL_URL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSError *error = nil;
        
        if (!error)//if everything good call block with data
            completion(nil);
        else
            completion( error);
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (completion)
            completion( error);
        
    }];
    
    

}

- (void)postBooks:(Book*) book andCompletion:(void(^)(NSMutableArray *arr, NSError *error))completion
{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject: book.title forKey:@"title" ];
    [params setObject: book.author forKey:@"author" ];
    [params setObject: book.categories forKey:@"categories" ];
    [params setObject: book.publisher forKey:@"publisher" ];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    AFSecurityPolicy* policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    [policy setValidatesDomainName:NO];
    
    [policy setAllowInvalidCertificates:YES];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",nil];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain",nil];
    
    
    
    [manager POST:BASE_URL parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        
        NSError *error = nil;
        NSMutableArray *arr = (NSMutableArray*)responseObject;
        
        if (!error)
            completion(arr, nil);
        else
            completion(nil, error);
        

    }
          failure:^(NSURLSessionTask *operation, NSError *error)
     
     {
         
             if (completion)
             completion(nil, error);
       }];

    
}

- (void)putBooks:(NSString*) userName andDate:(NSString*) date andBookID :(NSInteger) bookID andCompletion:(void(^)(NSMutableArray *arr, NSError *error))completion
{
    
    
    NSString *updateURL = [SERVER_URL stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)bookID]];
    
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            
                            date, @"lastCheckedOut",
                            userName, @"lastCheckedOutBy",
                            
                            nil];
    
    
   
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    AFSecurityPolicy* policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    [policy setValidatesDomainName:NO];
    
    [policy setAllowInvalidCertificates:YES];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",nil];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain",nil];
    
    
    
    [manager PUT:updateURL parameters:params success:^(NSURLSessionTask *task, id responseObject) {
        
        
        
        NSError *error = nil;
        NSMutableArray *arr = (NSMutableArray*)responseObject;
        
        if (!error)
            completion(arr, nil);
        else
            completion(nil, error);
        
        
    }
         failure:^(NSURLSessionTask *operation, NSError *error)
     
     {
                 NSLog(@"Error: %@", error);
         if (completion)
             completion(nil, error);
         
               
     }];

    
}


@end
