//
//  FiltrofyTableViewController.h
//  Fitrofy
//
//  Created by Helen Olhausen on 10/30/15.
//  Copyright © 2015 Helen Olhausen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FiltrofyFilterViewController.h"
#import "FiltrofyRemoteDataLoader.h"

@interface FiltrofyTableViewController : UIViewController <UITableViewDelegate,
                                                           UITableViewDataSource,
                                                           FilterDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray * fetchedRemoteData;
@property (nonatomic, strong) FiltrofyRemoteDataLoader * remoteLoader;

@end
