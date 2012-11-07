#import "ZBAppDelegate.h"
#import "ZBTableViewController.h"

@implementation ZBAppDelegate

- (void)dealloc
{
	[_window release];
	[_navController release];
	[super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
	ZBTableViewController *controller = [[ZBTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
	self.navController = [[[UINavigationController alloc] initWithRootViewController:controller] autorelease];
	[controller release];
	self.window.rootViewController = self.navController;
	[self.window makeKeyAndVisible];
	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
}
- (void)applicationDidEnterBackground:(UIApplication *)application
{
}
- (void)applicationWillEnterForeground:(UIApplication *)application
{
}
- (void)applicationDidBecomeActive:(UIApplication *)application
{
}
- (void)applicationWillTerminate:(UIApplication *)application
{
}

@synthesize window = _window;
@synthesize navController = _navController;

@end
