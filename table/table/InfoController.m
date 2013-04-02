//
//  InfoController.m
//  table
//
//  Created by Anna Balytska on 4/1/13.
//  Copyright (c) 2013 softserve. All rights reserved.
//

#import "InfoController.h"

@interface InfoController ()
@end

@implementation InfoController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect frame = CGRectMake(0, 0, 400, 44);
    UILabel *label = [[[UILabel alloc] initWithFrame:frame] autorelease];
    label.font = [UIFont fontWithName:@"Helvetica" size:14];
    label.text=[[_infoArray objectAtIndex:_number] name];
    label.numberOfLines=0;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    self.navigationItem.titleView=label;
    //self.title=[[_infoArray objectAtIndex:_number]objectForKey:@"name"];
    
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = backBarButtonItem;
    [backBarButtonItem release];
}

-(void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    id text;
    DiscountObject *obj=[_infoArray objectAtIndex:_number];
    cell.info.numberOfLines=0;
    if (indexPath.row==0){
        text= [[_infoArray objectAtIndex:_number] address];
        if (![text isKindOfClass:[NSNull class]]) {
            cell.info.text=[obj address];
            if([cell.info.text length]>0)
                cell.category.text=@"address";
            else
                cell.category.text=@"";
        }
        else {
            cell.category.text=@"";
            cell.info.text=@"";
        }
    }
    else if (indexPath.row==1) {
        text= [[_infoArray objectAtIndex:_number]pulse];
        if (![text isKindOfClass:[NSNull class]])  {
            cell.info.text=[obj pulse];
            if([cell.info.text length]>0)
                cell.category.text=@"pulse";
            else
                cell.category.text=@"";
        }
        else {
            cell.category.text=@"";
            cell.info.text=@"";
        }
    }
    else {        
        text= [[_infoArray objectAtIndex:_number]discount];
        if (![text isKindOfClass:[NSNull class]])  {
            cell.info.text=[obj discount];
            if([cell.info.text length]>0)
                cell.category.text=@"discount";
            else
                cell.category.text=@"";
        }
        else {
            cell.category.text=@"";
            cell.info.text=@"";
        }

        if([cell.info.text length]>0 && ([cell.info.text rangeOfString:@"null"].location == NSNotFound))
            cell.category.text=@"discount";
        else {
            cell.category.text=@"";
            cell.info.text=@"";
        }
    }
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{   
    id theString;
    if (indexPath.row==0)
        theString=[[_infoArray objectAtIndex:_number]address];
    else if (indexPath.row==1)
        theString=[[_infoArray objectAtIndex:_number]pulse];
    else
        theString=[[_infoArray objectAtIndex:_number]discount];
    CGSize textSize;
    if (![theString isKindOfClass:[NSNull class]]) 
         textSize= [theString sizeWithFont:[UIFont systemFontOfSize:13.0]
                            constrainedToSize:CGSizeMake(300.0f, CGFLOAT_MAX)
                                lineBreakMode:NSLineBreakByClipping];
    else {
        textSize.height=0;
        textSize.width=0;
    }
    if (textSize.height>0)
        return textSize.height+26;
    else
        return 0;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)dealloc
{
    [_infoArray release];
    [super dealloc];
}

@end
