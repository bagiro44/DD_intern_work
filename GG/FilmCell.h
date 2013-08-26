//
//  FilmCell.h
//  GG
//
//  Created by Dmitriy Remezov on 24.08.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Films.h"
#import "DBClient.h"

@interface FilmCell : UITableViewCell

@property NSIndexPath *indexPath;
@property Films *film;


@property (weak, nonatomic) IBOutlet UILabel *FilmTitle;
@property (weak, nonatomic) IBOutlet UILabel *FilmYear;
@property (weak, nonatomic) IBOutlet UIButton *favButton;

- (IBAction)addToFavorites:(id)sender;


@end
