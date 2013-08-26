//
//  EditController.m
//  GG
//
//  Created by Dmitriy Remezov on 24.08.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import "EditController.h"

@interface EditController ()

@end

@implementation EditController
@synthesize film, pickerController, filmImage;

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
    self.genreNumber = 7;
    self.genreArray = [[NSArray alloc] initWithObjects:@"18+", @"Аниме", @"Биография", @"Боевик", @"Вестерн", @"Военный", @"Детектив", @"Детский", @"Документальный", @"Драма", @"Игра", @"История", @"Комедия", @"Концерт", @"Короткометражка", @"Криминал", @"Мелодрама", @"Музыка", @"Мультфиль", @"Мюзикл", @"Новости", @"Приключения", @"Семейный", @"Спорт", @"Ток-шоу", @"Триллер", @"Ужасы", @"Фантастика", @"Фентези", @"ТВ", nil];
    for (int i=0; i < [self.genreArray count]; i++)
    {
        if ([[self.genreArray objectAtIndex:i] isEqual:film.genre])
        {
            self.genreNumber = i;
        }
    }
    pickerController = [[UIImagePickerController alloc] init];
    pickerController.allowsImageEditing = NO;
    pickerController.delegate = self;
    pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    (film.titile)?self.editTitle.text = film.titile:nil;
    (film.year)?self.editYear.text = film.year:nil;
    (film.descriptionfilm)?self.editDescription.text = film.descriptionfilm:nil;
    (film.genre)?self.genre.text = film.genre:nil;
    [self.editFilmImage setHidden:NO];
    UIImage *image = [UIImage imageWithData:film.image];
    self.editFilmImage.image = image;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    if ([self.editTitle isFirstResponder] && [touch view] != self.editTitle)
    {[self.editTitle resignFirstResponder];}
    else if ([self.editYear isFirstResponder] && [touch view] != self.editYear)
     {[self.editYear resignFirstResponder];}
    else if ([self.editDescription isFirstResponder] && [touch view] != self.editDescription)
    {[self.editDescription resignFirstResponder];}
    [super touchesBegan:touches withEvent:event];
}

- (void) textViewDidBeginEditing:(UITextView *)textView {
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += -215;  /*specify the points to move the view up*/
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:-10];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}

- (void) textViewDidEndEditing:(UITextView *)textView
{
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += 215;   /*specify the points to move the view down*/
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:-10];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
    [textView resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelEditView:(id)sender
{
    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [segue.destinationViewController setFilmDetail:film];
    if(![[DBClient sharedInstance] insertToDB:film])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:@"Не удалось добавить фильм в избранное..." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
    }
    
}

- (IBAction)saveEditing:(id)sender
{
    //[segue.destinationViewController setFilmDetail:film];
    film.titile = self.editTitle.text;
    film.year = self.editYear.text;
    film.genre = self.genre.text;
    film.descriptionfilm = self.editDescription.text;
    film.image = self.imageData ;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateDetail" object:self];
    if(![[DBClient sharedInstance] insertToDB:film])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:@"Не удалось добавить фильм в избранное..." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
    }
    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)editImage:(id)sender
{
    [self presentModalViewController:pickerController animated:YES];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissModalViewControllerAnimated:YES];
    filmImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    self.editFilmImage.image = filmImage;
    self.imageData = UIImagePNGRepresentation(filmImage);
    film.image = self.imageData;
}

#pragma PickerView
#pragma -

- (IBAction)editGenre:(id)sender
{
    self.actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:nil
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:nil];
    
    [self.actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    
    CGRect pickerFrame = CGRectMake(0, 40, 0, 0);
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
    pickerView.showsSelectionIndicator = YES;
    pickerView.dataSource = self;
    pickerView.delegate = self;
    [pickerView selectRow:self.genreNumber inComponent:0 animated:YES];
    
    [self.actionSheet addSubview:pickerView];
    
    UISegmentedControl *closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Close"]];
    closeButton.momentary = YES;
    closeButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
    closeButton.segmentedControlStyle = UISegmentedControlStyleBar;
    closeButton.tintColor = [UIColor blackColor];
    [closeButton addTarget:self action:@selector(dismissActionSheet:) forControlEvents:UIControlEventValueChanged];
    [self.actionSheet addSubview:closeButton];
    
    [self.actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
    
    [self.actionSheet setBounds:CGRectMake(0, 0, 320, 485)];
}

-(void)dismissActionSheet:(UIButton *)sender
{
    [self.actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}

-(void)pickerView:(UIPickerView *)pickerView
     didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    self.genre.text = [self.genreArray objectAtIndex:row];
    self.genreNumber = &(row);
}


- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.genreArray count];
}

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.genreArray objectAtIndex:row];
}

@end
