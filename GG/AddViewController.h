//
//  AddViewController.h
//  GG
//
//  Created by Dmitriy Remezov on 24.08.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Films.h"
#import "DBClient.h"

@interface AddViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *addFilmTitle;

- (IBAction)closeAddView:(id)sender;

@end
