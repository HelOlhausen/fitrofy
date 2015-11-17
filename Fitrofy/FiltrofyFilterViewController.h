//
//  FiltrofyFilterViewController.h
//  Fitrofy
//
//  Created by Helen Olhausen on 10/30/15.
//  Copyright © 2015 Helen Olhausen. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const kCell =  @"cell";

@protocol FilterDelegate;

@interface FiltrofyFilterViewController : UITableViewController

@property (nonatomic,strong) NSString * baseRIURL;
@property (nonatomic,strong) NSArray * fetchedFilters;
@property (nonatomic,strong) id<FilterDelegate> delegate;
@property (nonatomic,strong) NSString * filterName;
@end

@protocol FilterDelegate <NSObject>
@required
-(void)didChangeFilter:(FiltrofyFilterViewController *)filterTableController;
@end
