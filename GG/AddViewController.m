//
//  AddViewController.m
//  GG
//
//  Created by Dmitriy Remezov on 24.08.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import "AddViewController.h"
#import "EditController.h"

@interface AddViewController ()

@end

@implementation AddViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    NSLog(@"test");
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.navigationItem.title =  @"Фильмотека";
    // Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeAddView:(id)sender
{
        [self dismissViewControllerAnimated:YES completion:nil];
}
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([[DBClient sharedInstance] searchElementByTitle:self.addFilmTitle.text])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:@"Данный фильм уже существует в базе данных" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
        return NO;
    }
    if (self.addFilmTitle.text.length == 0)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:@"Название фильма не введено..." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
        return NO;
    }
    return YES;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"addToEdit"])
    {
        Films *film = [[DBClient sharedInstance] addNewFilmWIthTitle:self.addFilmTitle.text];
        [segue.destinationViewController setFilm:film];
    }
}

@end
