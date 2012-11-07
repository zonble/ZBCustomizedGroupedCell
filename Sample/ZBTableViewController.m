#import "ZBTableViewController.h"
#import "ZBCusomizedTableViewCell.h"

@implementation ZBTableViewController

- (void)removeOutletsAndControls_ZBTableViewController
{
}
- (void)dealloc
{
	[self removeOutletsAndControls_ZBTableViewController];
	[super dealloc];
}
- (void)viewDidUnload
{
	[super viewDidUnload];
	[self removeOutletsAndControls_ZBTableViewController];
}

- (id)initWithStyle:(UITableViewStyle)inStyle
{
	self = [super initWithStyle:inStyle];
	if (self) {
	}
	return self;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";

	ZBCusomizedTableViewCell *cell = (ZBCusomizedTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[ZBCusomizedTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	}
	cell.useAlternativeColor = (BOOL)(indexPath.row % 2);
	cell.textLabel.text = [NSString stringWithFormat:@"%d - %d", indexPath.section, indexPath.row];
	return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	return nil;
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
	return nil;
}

@end
