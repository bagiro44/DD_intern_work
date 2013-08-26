//
//  DetailViewController.m
//  GG
//
//  Created by Dmitriy Remezov on 24.08.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import "DetailViewController.h"
#import "EditController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize filmDetail;

- (void) filmDetail:(Films *)_film
{
    self.filmDetail = _film;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"updateDetail" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkRes:) name:@"updateDetail"
                                               object:nil];
    
    self.title = self.filmDetail.titile;
    self.filmGenre.text = self.filmDetail.genre;
    self.filmYear.text = self.filmDetail.year;
    self.filmDescription.text = self.filmDetail.descriptionfilm;
    self.filmImage.image = [UIImage imageWithData:filmDetail.image];
    
	
}

-(void)checkRes:(NSNotification *)notification
{
    if ([[notification name] isEqualToString:@"updateDetail"])
    {
        self.title = self.filmDetail.titile;
        self.filmGenre.text = self.filmDetail.genre;
        self.filmYear.text = self.filmDetail.year;
        self.filmDescription.text = self.filmDetail.descriptionfilm;
        self.filmImage.image = [UIImage imageWithData:filmDetail.image];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"detailToEdit"])
    {
        [segue.destinationViewController setFilm:filmDetail];
    }
}

@end
