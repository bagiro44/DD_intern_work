//
//  EditController.h
//  GG
//
//  Created by Dmitriy Remezov on 24.08.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Films.h"
#import "DetailViewController.h"
#import "DBClient.h"

@interface EditController : UIViewController <UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UITextField *editTitle;
@property (weak, nonatomic) IBOutlet UITextField *editYear;
@property (weak, nonatomic) IBOutlet UITextView *editDescription;
@property (weak, nonatomic) IBOutlet UIImageView *editFilmImage;
@property (weak, nonatomic) IBOutlet UIButton *editImageButton;
@property UIImagePickerController *pickerController;
@property UIImage *filmImage;
@property UIActionSheet *actionSheet;
@property NSArray *genreArray;
@property (weak, nonatomic) IBOutlet UILabel *genre;
@property NSInteger *genreNumber;
@property NSData *imageData;

@property Films *film;
- (IBAction)editGenre:(id)sender;
- (IBAction)cancelEditView:(id)sender;
- (IBAction)saveEditing:(id)sender;
- (IBAction)editImage:(id)sender;

@end
