//
//  ViewController.m
//  GG
//
//  Created by Dmitriy Remezov on 24.08.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"


@interface ViewController ()

@end

@implementation ViewController

@synthesize film, oneFilm;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }    
    [super viewDidLoad];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"updateRightTable" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkRes:) name:@"updateRightTable"
    object:nil];
    /*int sections = [self.tableView numberOfSections];
    BOOL hasRows = NO;
    for (int i = 0; i < sections; i++)
        hasRows = ([self.tableView numberOfRowsInSection:i] > 0) ? YES : NO;
    if (sections == 0 || hasRows == NO)
    {}*/

}

-(void)checkRes:(NSNotification *)notification
{
    if ([[notification name] isEqualToString:@"updateRightTable"])
    {
        film = [[[DBClient sharedInstance] selectFilmFavorite:NO] mutableCopy];
        
        [self.tableView reloadData];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [film count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId = @"FilmCell";
    FilmCell *cell;
    oneFilm = [film objectAtIndex:indexPath.row];
    
    cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    
    if ([oneFilm.favorite isEqual:[NSNumber numberWithBool:YES]])
    {
        UIImage *favOnImage = [UIImage imageNamed:@"yellowStar"];
        [cell.favButton setBackgroundImage:favOnImage forState:UIControlStateNormal];
        NSLog(@"%lu", (long)indexPath.row);
    }else
    {
        UIImage *favOnImage = [UIImage imageNamed:@"greyStar"];
        [cell.favButton setBackgroundImage:favOnImage forState:UIControlStateNormal];
    }
    
    cell.film = oneFilm;
    cell.FilmTitle.text = oneFilm.titile;
    cell.FilmYear.text = oneFilm.year;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    oneFilm = [film objectAtIndex:indexPath.row];    
}

- (UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCellEditingStyle result = UITableViewCellEditingStyleNone;
    if([tableView isEqual:self.tableView])
    {
        result = UITableViewCellEditingStyleDelete;
    }
    return result;
}

- (void) setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        if (indexPath.row < [self.film count])
        {
            NSLog(@"%@", film.description);
            [[DBClient sharedInstance] deleteFilm:[film objectAtIndex:indexPath.row]];
            [self.film removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        }
    }
}

- (IBAction)helpToApp:(id)sender {
}

- (void) refreshData
{
    film = [[[DBClient sharedInstance] selectFilmFavorite:NO] mutableCopy];
    [self.tableView reloadData];
}

- (void) viewWillAppear:(BOOL)animated
{
    [self refreshData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"mainToDetail"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        [segue.destinationViewController setFilmDetail:[film objectAtIndex:indexPath.row]];
        
    }
}
@end
