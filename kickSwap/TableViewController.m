//
//  PFQueryTableViewController+TableViewController.m
//  kickSwap
//
//  Created by Hugh A. Miles on 1/3/15.
//  Copyright (c) 2015 HAMtech. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController()

@end

@implementation TableViewController

@synthesize tableView;


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Pull data from parseTimeline
    [self performSelector:@selector(retrieveFromParse)];
    
    // Add pull to refresh to tableview
    ODRefreshControl *refreshControl = [[ODRefreshControl alloc] initInScrollView:self.tableView];
    [refreshControl addTarget:self action:@selector(dropViewDidBeginRefreshing:) forControlEvents:UIControlEventValueChanged];
};

- (void) retrieveFromParse {
    
    PFQuery *retrieveData = [PFQuery queryWithClassName:@"Timeline"];
    
    [retrieveData findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSLog(@"%@",objects);
        if (!error) {
            kicksArray = [[NSArray alloc] initWithArray:objects];
      
        }
        
        [tableView reloadData]; // reload tableView with new elements
    }];

}

- (void) dropViewDidBeginRefreshing: (ODRefreshControl *)refreshControl {
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){[refreshControl endRefreshing];
    });
    
    // Reload Data From Parse
    [self performSelector:@selector(retrieveFromParse)];
}

//////////Setup table of folder names////////////////////////////////////

//get number of sections in tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

//get number of rows by counting number of folders
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return kicksArray.count;
}

//setup cells in tableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //setup cell
    static NSString *CellIdentifier = @"kicksCell";
    
    ksTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
   PFObject *tempObject = [kicksArray objectAtIndex:indexPath.row];
    
   cell.cellTitle.text = [tempObject objectForKey:@"text"];  //object key from Parse
   cell.shoeSize.text = [tempObject objectForKey:@"size"];
   
    //get kickPhoto and put into cellImage
    PFFile *imageFile = [tempObject objectForKey:@"picture"];
    [imageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if (!error) {
            cell.cellImage.image = [UIImage imageWithData:imageData];
        }
    }];
 
    return cell;
    
}


//user selects folder to add tag to
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"cell tapped");
    PFObject *tempObject = [kicksArray objectAtIndex:indexPath.row];
    NSLog(@"%@", tempObject.objectId);
    
    //Retrieve Description from Parse >> Description Label
    _kickPostDescription.text = [tempObject objectForKey:@"description"];
    
    //Display View
    [self displayKickPostInfo];
    
}

-(void) displayKickPostInfo
{
    [UIView animateWithDuration:0.5 animations:^{
        _kickPostDetails.frame = CGRectMake(0, 0, 400 , 751);
    }];
}

- (IBAction)backBtnPressed:(id)sender {
    [UIView animateWithDuration:0.5 animations:^{
        _kickPostDetails.frame = CGRectMake(400, 0, 400 , 751);
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
