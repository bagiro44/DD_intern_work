//
//  Films.h
//  GG
//
//  Created by Dmitriy Remezov on 26.08.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Films : NSManagedObject

@property (nonatomic, retain) NSString * descriptionfilm;
@property (nonatomic, retain) NSNumber * favorite;
@property (nonatomic, retain) NSString * genre;
@property (nonatomic, retain) NSString * titile;
@property (nonatomic, retain) NSString * year;
@property (nonatomic, retain) id image;

@end
