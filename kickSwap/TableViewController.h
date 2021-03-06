//
//  PFQueryTableViewController+TableViewController.h
//  kickSwap
//
//  Created by Hugh A. Miles on 1/3/15.
//  Copyright (c) 2015 HAMtech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "ksTableViewCell.h"
#import "ODRefreshControl.h"

@interface TableViewController : UIViewController <UITableViewDelegate>{
    
    NSArray *kicksArray;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *kickPostDetails;
@property (weak, nonatomic) IBOutlet UILabel *kickPostDescription;

@end
