//
//  RDMainTabBarViewController.m
//  RubyDay2013
//
//  Created by Federico Ravasio on 6/1/13.
//  Copyright (c) 2013 Webrain. All rights reserved.
//

#import "RDMainTabBarViewController.h"
#import "RDScheduleViewController.h"
#import "RDFavouritesViewController.h"
#import "RDSpeakersViewController.h"
#import "RDInfoViewController.h"

@interface RDMainTabBarViewController ()

@end

@implementation RDMainTabBarViewController

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

    [self loadTabs];
}

- (void)loadTabs
{
    UIViewController *agendaController = [self createAgendaController];
    UIViewController *favouritesController = [self createFavouritesController];
    UIViewController *speakersController = [self createSpeakersController];
    UIViewController *infoController = [self createInfoController];

    [self setViewControllers:@[agendaController,
                               favouritesController,
                               speakersController,
                               infoController]];
}

- (UIViewController *)createAgendaController
{
    RDScheduleViewController *scheduleController = [[RDScheduleViewController alloc] initWithNibName:@"RDScheduleViewController" bundle:[NSBundle mainBundle]];

    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:scheduleController];
    navigationController.tabBarItem.title = @"Agenda";

    return navigationController;
}

- (UIViewController *)createFavouritesController
{
    RDFavouritesViewController *favouritesController = [[RDFavouritesViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:favouritesController];
    navigationController.tabBarItem.title = @"Favourites";

    return navigationController;
}

- (UIViewController *)createSpeakersController
{
    RDSpeakersViewController *speakersController = [[RDSpeakersViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:speakersController];
    navigationController.tabBarItem.title = @"Speakers";

    return navigationController;
}

- (UIViewController *)createInfoController
{
    RDInfoViewController *infoViewController = [[RDInfoViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:infoViewController];
    navigationController.tabBarItem.title = @"Info";

    return navigationController;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
