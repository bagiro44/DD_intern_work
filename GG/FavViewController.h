//
//  FavViewController.h
//  GG
//
//  Created by Dmitriy Remezov on 24.08.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBClient.h"
#import "Films.h"
#import "FilmCell.h"

@interface FavViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property NSMutableArray *film;
@property Films *oneFilm;

- (void) refreshData;


@end
