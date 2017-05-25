//
//  BooksTableCell.h
//  Heroku
//
//  Created by Aswini Ramesh on 5/17/17.
//  Copyright © 2017 Aswini Ramesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BooksTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *Author;
@property (weak, nonatomic) IBOutlet UILabel *title;
@end
