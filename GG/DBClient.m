//
//  DBClient.m
//  GG
//
//  Created by Dmitriy Remezov on 24.08.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import "DBClient.h"

@interface DBClient ()
@property (nonatomic, strong, readwrite) NSManagedObjectContext *ManagedObjectContext; 
@end

@implementation DBClient

+ (DBClient *)sharedInstance;
{
	static dispatch_once_t p = 0;
	__strong static id _sharedObject = nil;
	dispatch_once(&p, ^{
		_sharedObject = [[self alloc] init];
	});
	return _sharedObject;
}

-(id)init
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    NSError *error = nil;
    NSString *const kDataBaseFileName = @"Films.sqlite";
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *dataBasePath = [documentDirectory stringByAppendingPathComponent:kDataBaseFileName];
    
    NSManagedObjectModel *ObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    NSPersistentStoreCoordinator *StoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:ObjectModel];
    [StoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:Nil URL:[NSURL fileURLWithPath:dataBasePath] options:nil error:&error];
    
    NSManagedObjectContext *ManagedObjectContext = [[NSManagedObjectContext alloc] init];
    ManagedObjectContext.persistentStoreCoordinator = StoreCoordinator;
    self.ManagedObjectContext = ManagedObjectContext;
    return self;
}

- (NSMutableArray *) selectFilmFavorite:(BOOL)favorite
{
    NSMutableArray *films = nil;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    if(!favorite)
    {
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Films" inManagedObjectContext:self.ManagedObjectContext];
        [fetchRequest setEntity:entity];
        NSError *error;
        films = [self.ManagedObjectContext executeFetchRequest:fetchRequest error:&error];
        return films;
    }else
    {
        [fetchRequest setEntity:[NSEntityDescription entityForName:@"Films" inManagedObjectContext:self.ManagedObjectContext]];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"favorite == %@", @"1"];
        [fetchRequest setPredicate:predicate];
        NSError *error;
        films = [self.ManagedObjectContext executeFetchRequest:fetchRequest error:&error];
        return films;        
    }
}

- (BOOL *) insertToDB:(Films *)Film
{
    
    NSError *error;
    if ([self.ManagedObjectContext save:&error])
    {
        NSLog(@"Succesfull add");
        [self reloadData];        
        return YES;
    } else
    {
        NSLog(@"Not succesfull add");
        return NO;
    }

}

- (BOOL *) insertFavoriteToDB:(Films *)Film
{
    
    NSError *error;
    if ([self.ManagedObjectContext save:&error])
    {
        NSLog(@"Succesfull add");
        [self refreshData];
        return YES;
    } else
    {
        NSLog(@"Not succesfull add");
        return NO;
    }
    
}

- (Films *) addNewFilmWIthTitle:(NSString *)title
{
    Films *filmToAdd = [NSEntityDescription insertNewObjectForEntityForName:@"Films" inManagedObjectContext:self.ManagedObjectContext];
    filmToAdd.titile = title;
    filmToAdd.favorite = [NSNumber numberWithBool:NO];
    NSError *error;
    if ([self.ManagedObjectContext save:&error])
    {
        NSLog(@"Succesfull add");
        [self reloadData];
        return filmToAdd;
    } else
    {
        NSLog(@"Not succesfull add");
        return NO;
    }
}
- (BOOL *) searchElementByTitle:(NSString *)title
{
    NSArray *films = nil;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"Films" inManagedObjectContext:self.ManagedObjectContext]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"titile == %@", title];
    [fetchRequest setPredicate:predicate];
    NSError *error;
    films = [self.ManagedObjectContext executeFetchRequest:fetchRequest error:&error];
    if ([films count])
    {
        return YES;
    }
    return NO;
}

- (BOOL *) deleteFilm:(Films *)film
{
    //NSMutableArray *filmArray = [self selectFilmFavorite:NO];
    [self.ManagedObjectContext deleteObject:film];
    NSError *error;
    if ([self.ManagedObjectContext save:&error])
    {
        NSLog(@"Succesfull add");
        [self reloadData];
        return YES;
    } else
    {
        NSLog(@"Not succesfull add");
        return NO;
    }
}


- (BOOL *) reloadData
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateLeftTable" object:self];
    return YES;
}

- (BOOL *) refreshData
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateRightTable" object:self];
    return YES;
}


@end
