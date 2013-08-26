//
//  FilmCell.m
//  GG
//
//  Created by Dmitriy Remezov on 24.08.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import "FilmCell.h"

@implementation FilmCell

@synthesize film, indexPath;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    UIImage *favOnImage = [UIImage imageNamed:@"43-film-roll.png"];
    [self.favButton setBackgroundImage:favOnImage forState:UIControlStateNormal];
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)addToFavorites:(id)sender
{
    if ([self.film.favorite isEqual:[NSNumber numberWithBool:YES]])
    {
        //UIImage *favOnImage = [UIImage imageNamed:@"43-film-roll.png"];
        //[self.favButton setBackgroundImage:favOnImage forState:UIControlStateNormal];
        self.film.favorite = [NSNumber numberWithBool:NO];
    }else
    {
        //UIImage *favOnImage = [UIImage imageNamed:@"28-star"];
        //[self.favButton setBackgroundImage:favOnImage forState:UIControlStateNormal];
        self.film.favorite = [NSNumber numberWithBool:YES];
    }
    
    if(![[DBClient sharedInstance] insertFavoriteToDB:film])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:@"Не удалось добавить фильм в избранное..." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
    }
}
@end
