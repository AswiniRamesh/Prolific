//
//  BooksTableCell.m
//  Heroku
//
//  Created by Aswini Ramesh on 5/17/17.
//  Copyright © 2017 Aswini Ramesh. All rights reserved.
//

#import "BooksTableCell.h"

@implementation BooksTableCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
