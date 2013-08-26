//
//  DetailViewController.h
//  GG
//
//  Created by Dmitriy Remezov on 24.08.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Films.h"

@interface DetailViewController : UIViewController

@property Films *filmDetail;

@property (weak, nonatomic) IBOutlet UILabel *filmYear;
@property (weak, nonatomic) IBOutlet UILabel *filmGenre;
@property (weak, nonatomic) IBOutlet UITextView *filmDescription;
@property (weak, nonatomic) IBOutlet UIImageView *filmImage;



@end
