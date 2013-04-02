//
//  TableViewCell.h
//  table
//
//  Created by Anna Balytska on 4/1/13.
//  Copyright (c) 2013 softserve. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *category;
@property (retain, nonatomic) IBOutlet UILabel *info;
@end
