//
//  ViewController.m
//  table
//
//  Created by Anna Balytska on 3/29/13.
//  Copyright (c) 2013 softserve. All rights reserved.
//
#define Queue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define URL [NSURL URLWithString:@"https://softserve.ua/api/v1/object/list/b1d6f099e1b5913e86f0a9bb9fbc10e5"]

#import "ViewController.h"
#import "InfoController.h"

@interface ViewController ()
@property NSDictionary* json;
@property NSMutableArray *data;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    dispatch_async(Queue, ^{
        NSData* data = [NSData dataWithContentsOfURL:URL];
        [self performSelectorOnMainThread:@selector(fetchedData:)
                               withObject:data waitUntilDone:YES];
    });
    self.title=@"SoftServe Discount";
    _data=[[NSMutableArray alloc]init];
 }

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
}

- (void)fetchedData:(NSData *)responseData {
    NSError* error;
    _json = [NSJSONSerialization
                          JSONObjectWithData:responseData 
                          options:kNilOptions
                          error:&error];
    
    for (int i=0;i<[[_json objectForKey:@"list"] count];i++) {
        DiscountObject *object=[[[DiscountObject alloc]init]autorelease];
        object.name=[[[_json objectForKey:@"list"] objectAtIndex:i]valueForKey:@"name"];
        object.address=[[[_json objectForKey:@"list"] objectAtIndex:i]valueForKey:@"address"];
        object.pulse=[[[_json objectForKey:@"list"] objectAtIndex:i]valueForKey:@"pulse"];
      
        id from,to;
        from=[[[[_json objectForKey:@"list"] objectAtIndex:i]objectForKey:@"discount"]objectForKey:@"from"];
        to=[[[[_json objectForKey:@"list"] objectAtIndex:i]objectForKey:@"discount"]objectForKey:@"to"];
        
        
        if ([from isEqual:to])
            object.discount=[NSString stringWithFormat:@"%@%%",from];
        else
            object.discount=[NSString stringWithFormat:@"from: %@%% to: %@%%",from,to];
 
        
//        NSLog(@"%@ %@",from,to);
                
        [_data addObject:object];
    }

    NSMutableArray *indexes = [[[NSMutableArray alloc] init]autorelease];
    for (int i=0;i < [_data count]; i++) {
        [indexes addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:indexes withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView endUpdates];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *theString = [[_data objectAtIndex:indexPath.row] name];
    CGSize textSize = [theString sizeWithFont:[UIFont systemFontOfSize:14.0]
                            constrainedToSize:CGSizeMake(280.0f, CGFLOAT_MAX)
                                lineBreakMode:NSLineBreakByClipping];

    return textSize.height+20;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    InfoController *info = segue.destinationViewController;
    info.number = indexPath.row;
    info.infoArray=_data;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return [_data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.textLabel.numberOfLines=0;
    cell.textLabel.text=[[_data objectAtIndex:indexPath.row] name];
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_tableView release];
    [_data release];
    [super dealloc];
}
@end
