#import "ZBCusomizedTableViewCell.h"
#import <QuartzCore/QuartzCore.h>

@protocol ZBCellSelectedBackgrondViewDelegate <NSObject>
- (void)drawSelectedBackground:(CGRect)inBounds;
@end

@interface ZBCellSelectedBackgrondView : UIView
{
	id delegate;
}
@property (assign, nonatomic) id delegate;
@end

@implementation ZBCellSelectedBackgrondView
- (id)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame]) {
		self.opaque = YES;
		self.backgroundColor = [UIColor clearColor];
	}
	return self;
}
- (void)drawRect:(CGRect)rect
{
	[super drawRect:rect];
	[delegate drawSelectedBackground:self.bounds];
}
@synthesize delegate;
@end

@protocol ZBCellBackgrondViewDelegate <NSObject>
- (void)drawBackground:(CGRect)inBounds;
@end

@interface ZBCellBackgrondView : UIView
{
	id delegate;
}
@property (assign, nonatomic) id delegate;
@end

@implementation ZBCellBackgrondView
- (id)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame]) {
		self.opaque = YES;
		self.backgroundColor = [UIColor clearColor];
	}
	return self;
}
- (void)drawRect:(CGRect)rect
{
	[super drawRect:rect];
	[delegate drawBackground:self.bounds];
}
@synthesize delegate;
@end

@interface ZBCusomizedTableViewCell()
- (void)drawPlainStyleSelectedBackgroundWithBounds:(CGRect)inBounds forRowAtIndexPath:(NSIndexPath *)inIndexPath;
- (void)drawGroupStyleSelectedBackgroundWithBounds:(CGRect)inBounds forRowAtIndexPath:(NSIndexPath *)inIndexPath;
- (void)drawPlainStyleBackgroundWithBounds:(CGRect)inBounds forRowAtIndexPath:(NSIndexPath *)inIndexPath;
- (void)drawGroupStyleBackgroundWithBounds:(CGRect)inBounds forRowAtIndexPath:(NSIndexPath *)inIndexPath;
@end

@implementation ZBCusomizedTableViewCell

- (void)dealloc
{
	tableView = nil;
	[super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		ZBCellBackgrondView *ourBackgroundView = [[ZBCellBackgrondView alloc] initWithFrame:CGRectZero];
		ourBackgroundView.delegate = (id <ZBCellBackgrondViewDelegate> )self;
		[ourBackgroundView setNeedsDisplay];
		self.backgroundView = ourBackgroundView;
		[ourBackgroundView release];

		ZBCellSelectedBackgrondView *ourSelectedBackgroundView = [[ZBCellSelectedBackgrondView alloc] initWithFrame:CGRectZero];
		ourSelectedBackgroundView.delegate = (id <ZBCellSelectedBackgrondViewDelegate> )self;
		[ourSelectedBackgroundView setNeedsDisplay];
		self.selectedBackgroundView = ourSelectedBackgroundView;
		[ourSelectedBackgroundView release];

		self.textLabel.backgroundColor = [UIColor clearColor];
		self.textLabel.textColor = [UIColor darkGrayColor];
	}
	return self;
}

#pragma mark -

- (void)drawSelectedBackground:(CGRect)inBounds
{
	NSIndexPath *indexPath = [tableView indexPathForCell:self];
	if (!indexPath) {
		return;
	}

	if (tableView.style == UITableViewStylePlain) {
		[self drawPlainStyleSelectedBackgroundWithBounds:inBounds forRowAtIndexPath:indexPath];
	}
	else {
		[self drawGroupStyleSelectedBackgroundWithBounds:inBounds forRowAtIndexPath:indexPath];
	}
}

- (void)drawPlainStyleSelectedBackgroundWithBounds:(CGRect)inBounds forRowAtIndexPath:(NSIndexPath *)inIndexPath
{
	UIColor *backgroundColor = [UIColor redColor];
	UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(CGRectGetMinX(inBounds), CGRectGetMinY(inBounds), CGRectGetMaxX(inBounds), CGRectGetMaxY(inBounds))];
	[backgroundColor setFill];
	[path fill];
}

- (void)drawGroupStyleSelectedBackgroundWithBounds:(CGRect)inBounds forRowAtIndexPath:(NSIndexPath *)inIndexPath
{
	NSUInteger cellCount = [tableView.dataSource tableView:tableView numberOfRowsInSection:inIndexPath.section];
	UIColor *backgroundColor =	[UIColor redColor];
	CGFloat radius = 20.0;

	inBounds.origin.x += 1.0;
	inBounds.size.width -= 2.0;

	if (cellCount == 1) { // only one row
		inBounds.origin.y += 1.0;
		inBounds.size.height -= 2.0;
		UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:inBounds cornerRadius:10.0];
		path.lineWidth = 1.0;
		[backgroundColor setFill];
		[path fill];
	}
	else if (inIndexPath.row == 0) { // the first row
		inBounds.origin.y += 1.0;
		inBounds.size.height -= 1.0;
		UIBezierPath *path = [UIBezierPath bezierPath];
		path.lineWidth = 1.0;
		[path moveToPoint:CGPointMake(CGRectGetMinX(inBounds), CGRectGetMaxY(inBounds))];
		[path addLineToPoint:CGPointMake(CGRectGetMinX(inBounds), CGRectGetMinY(inBounds) + radius)];
		[path addCurveToPoint:CGPointMake(CGRectGetMinX(inBounds) + radius,	 CGRectGetMinY(inBounds)) controlPoint1:CGPointMake(CGRectGetMinX(inBounds),  CGRectGetMinY(inBounds)) controlPoint2:CGPointMake(CGRectGetMinX(inBounds),  CGRectGetMinY(inBounds))];
		[path addLineToPoint:CGPointMake(CGRectGetMaxX(inBounds) - radius, CGRectGetMinY(inBounds))];
		[path addCurveToPoint:CGPointMake(CGRectGetMaxX(inBounds),	CGRectGetMinY(inBounds) + radius) controlPoint1:CGPointMake(CGRectGetMaxX(inBounds),  CGRectGetMinY(inBounds)) controlPoint2:CGPointMake(CGRectGetMaxX(inBounds),  CGRectGetMinY(inBounds))];
		[path addLineToPoint:CGPointMake(CGRectGetMaxX(inBounds), CGRectGetMaxY(inBounds))];
		[path addLineToPoint:CGPointMake(CGRectGetMinX(inBounds), CGRectGetMaxY(inBounds))];
		[backgroundColor setFill];
		[path fill];
	}
	else if (inIndexPath.row >= cellCount - 1) { // the last row
		inBounds.size.height -= 1.0;
		UIBezierPath *path = [UIBezierPath bezierPath];
		path.lineWidth = 1.0;
		[path moveToPoint:CGPointMake(CGRectGetMinX(inBounds), CGRectGetMinY(inBounds))];
		[path addLineToPoint:CGPointMake(CGRectGetMinX(inBounds), CGRectGetMaxY(inBounds) - radius)];
		[path addCurveToPoint:CGPointMake(CGRectGetMinX(inBounds) + radius,	 CGRectGetMaxY(inBounds)) controlPoint1:CGPointMake(CGRectGetMinX(inBounds),  CGRectGetMaxY(inBounds)) controlPoint2:CGPointMake(CGRectGetMinX(inBounds),  CGRectGetMaxY(inBounds))];
		[path addLineToPoint:CGPointMake(CGRectGetMaxX(inBounds) - radius, CGRectGetMaxY(inBounds))];
		[path addCurveToPoint:CGPointMake(CGRectGetMaxX(inBounds),	CGRectGetMaxY(inBounds) - radius) controlPoint1:CGPointMake(CGRectGetMaxX(inBounds),  CGRectGetMaxY(inBounds)) controlPoint2:CGPointMake(CGRectGetMaxX(inBounds),  CGRectGetMaxY(inBounds))];
		[path addLineToPoint:CGPointMake(CGRectGetMaxX(inBounds), CGRectGetMinY(inBounds))];
		[path closePath];
		[backgroundColor setFill];
		[path fill];
	}
	else {
		UIBezierPath *path = [UIBezierPath bezierPathWithRect:inBounds];
		path.lineWidth = 1.0;
		[backgroundColor setFill];
		[path fill];
	}
}


#pragma mark -

- (void)drawBackground:(CGRect)inBounds
{
	NSIndexPath *indexPath = [tableView indexPathForCell:self];
	if (!indexPath) {
		return;
	}

	if (tableView.style == UITableViewStylePlain) {
		[self drawPlainStyleBackgroundWithBounds:inBounds forRowAtIndexPath:indexPath];
	}
	else {
		[self drawGroupStyleBackgroundWithBounds:inBounds forRowAtIndexPath:indexPath];
	}
}

- (void)drawPlainStyleBackgroundWithBounds:(CGRect)inBounds forRowAtIndexPath:(NSIndexPath *)inIndexPath
{
	NSUInteger cellCount = [tableView.dataSource tableView:tableView numberOfRowsInSection:inIndexPath.section];
	UIColor *backgroundColor = useAlternativeColor ? [UIColor whiteColor] : [UIColor lightGrayColor];
	UIColor *borderColor = [UIColor blackColor];

	UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(CGRectGetMinX(inBounds), CGRectGetMinY(inBounds), CGRectGetMaxX(inBounds), CGRectGetMaxY(inBounds))];
	[backgroundColor setFill];
	[path fill];

	UIBezierPath *topLinePath = [UIBezierPath bezierPath];
	topLinePath.lineWidth = 1.0;
	[topLinePath moveToPoint:CGPointMake(CGRectGetMinX(inBounds), CGRectGetMinY(inBounds) + 1.5)];
	[topLinePath addLineToPoint:CGPointMake(CGRectGetMaxX(inBounds), CGRectGetMinY(inBounds) + 1.5)];
	[[UIColor whiteColor] setStroke];
	[topLinePath stroke];

	topLinePath = [UIBezierPath bezierPath];
	topLinePath.lineWidth = 1.0;
	[topLinePath moveToPoint:CGPointMake(CGRectGetMinX(inBounds), CGRectGetMinY(inBounds) + 0.5)];
	[topLinePath addLineToPoint:CGPointMake(CGRectGetMaxX(inBounds), CGRectGetMinY(inBounds) + 0.5)];
	[borderColor setStroke];
	[topLinePath stroke];

	if (cellCount == 1 || inIndexPath.row >= cellCount - 1) {
		UIBezierPath *underlinePath = [UIBezierPath bezierPath];
		underlinePath.lineWidth = 1.0;
		[underlinePath moveToPoint:CGPointMake(CGRectGetMinX(inBounds), CGRectGetMaxY(inBounds) - 1.5)];
		[underlinePath addLineToPoint:CGPointMake(CGRectGetMaxX(inBounds), CGRectGetMaxY(inBounds) - 1.5)];
		[underlinePath closePath];
		[borderColor setStroke];
		[underlinePath stroke];

		underlinePath = [UIBezierPath bezierPath];
		underlinePath.lineWidth = 1.0;
		[underlinePath moveToPoint:CGPointMake(CGRectGetMinX(inBounds), CGRectGetMaxY(inBounds) - 0.5)];
		[underlinePath addLineToPoint:CGPointMake(CGRectGetMaxX(inBounds), CGRectGetMaxY(inBounds) - 0.5)];
		[underlinePath closePath];
		[[UIColor whiteColor] setStroke];
		[underlinePath stroke];
	}
}

- (void)drawGroupStyleBackgroundWithBounds:(CGRect)inBounds forRowAtIndexPath:(NSIndexPath *)inIndexPath
{
	NSUInteger cellCount = [tableView.dataSource tableView:tableView numberOfRowsInSection:inIndexPath.section];
	UIColor *backgroundColor = useAlternativeColor ? [UIColor whiteColor] : [UIColor lightGrayColor];
	UIColor *borderColor = [UIColor blackColor];
	CGFloat radius = 20.0;

	inBounds.origin.x += 1.0;
	inBounds.size.width -= 2.0;

	if (cellCount == 1) { // only one row
		inBounds.origin.y += 1.0;
		inBounds.size.height -= 2.0;
		UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:inBounds cornerRadius:10.0];
		path.lineWidth = 1.0;
		[backgroundColor setFill];
		[borderColor setStroke];
		[path fill];
		[path stroke];
	}
	else if (inIndexPath.row == 0) { // the first row
		inBounds.origin.y += 1.0;
		inBounds.size.height -= 1.0;
		UIBezierPath *path = [UIBezierPath bezierPath];
		path.lineWidth = 1.0;
		[path moveToPoint:CGPointMake(CGRectGetMinX(inBounds), CGRectGetMaxY(inBounds))];
		[path addLineToPoint:CGPointMake(CGRectGetMinX(inBounds), CGRectGetMinY(inBounds) + radius)];
		[path addCurveToPoint:CGPointMake(CGRectGetMinX(inBounds) + radius,	 CGRectGetMinY(inBounds)) controlPoint1:CGPointMake(CGRectGetMinX(inBounds),  CGRectGetMinY(inBounds)) controlPoint2:CGPointMake(CGRectGetMinX(inBounds),  CGRectGetMinY(inBounds))];
		[path addLineToPoint:CGPointMake(CGRectGetMaxX(inBounds) - radius, CGRectGetMinY(inBounds))];
		[path addCurveToPoint:CGPointMake(CGRectGetMaxX(inBounds),	CGRectGetMinY(inBounds) + radius) controlPoint1:CGPointMake(CGRectGetMaxX(inBounds),  CGRectGetMinY(inBounds)) controlPoint2:CGPointMake(CGRectGetMaxX(inBounds),  CGRectGetMinY(inBounds))];
		[path addLineToPoint:CGPointMake(CGRectGetMaxX(inBounds), CGRectGetMaxY(inBounds))];
		[path addLineToPoint:CGPointMake(CGRectGetMinX(inBounds), CGRectGetMaxY(inBounds))];
		[backgroundColor setFill];
		[borderColor setStroke];
		[path fill];
		[path stroke];
	}
	else if (inIndexPath.row >= cellCount - 1) { // the last row
		inBounds.size.height -= 1.0;
		UIBezierPath *path = [UIBezierPath bezierPath];
		path.lineWidth = 1.0;
		[path moveToPoint:CGPointMake(CGRectGetMinX(inBounds), CGRectGetMinY(inBounds))];
		[path addLineToPoint:CGPointMake(CGRectGetMinX(inBounds), CGRectGetMaxY(inBounds) - radius)];
		[path addCurveToPoint:CGPointMake(CGRectGetMinX(inBounds) + radius,	 CGRectGetMaxY(inBounds)) controlPoint1:CGPointMake(CGRectGetMinX(inBounds),  CGRectGetMaxY(inBounds)) controlPoint2:CGPointMake(CGRectGetMinX(inBounds),  CGRectGetMaxY(inBounds))];
		[path addLineToPoint:CGPointMake(CGRectGetMaxX(inBounds) - radius, CGRectGetMaxY(inBounds))];
		[path addCurveToPoint:CGPointMake(CGRectGetMaxX(inBounds),	CGRectGetMaxY(inBounds) - radius) controlPoint1:CGPointMake(CGRectGetMaxX(inBounds),  CGRectGetMaxY(inBounds)) controlPoint2:CGPointMake(CGRectGetMaxX(inBounds),  CGRectGetMaxY(inBounds))];
		[path addLineToPoint:CGPointMake(CGRectGetMaxX(inBounds), CGRectGetMinY(inBounds))];
		[path closePath];
		[backgroundColor setFill];
		[borderColor setStroke];
		[path fill];
		[path stroke];

		path = [UIBezierPath bezierPath];
		path.lineWidth = 1.0;
		[path moveToPoint:CGPointMake(CGRectGetMinX(inBounds) + 1.0, CGRectGetMinY(inBounds) + 1.0)];
		[path addLineToPoint:CGPointMake(CGRectGetMaxX(inBounds) - 1.0, CGRectGetMinY(inBounds) + 1.0)];
		[[UIColor whiteColor] setStroke];
		[path stroke];
	}
	else {
		UIBezierPath *path = [UIBezierPath bezierPathWithRect:inBounds];
		path.lineWidth = 1.0;
		[backgroundColor setFill];
		[borderColor setStroke];
		[path fill];
		[path stroke];

		path = [UIBezierPath bezierPath];
		path.lineWidth = 1.0;
		[path moveToPoint:CGPointMake(CGRectGetMinX(inBounds) + 1.0, CGRectGetMinY(inBounds) + 1.0)];
		[path addLineToPoint:CGPointMake(CGRectGetMaxX(inBounds) - 1.0, CGRectGetMinY(inBounds) + 1.0)];
		[[UIColor whiteColor] setStroke];
		[path stroke];
	}
}

- (void)removeFromSuperview
{
	[super removeFromSuperview];
	tableView = nil;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
	[super willMoveToSuperview:newSuperview];
	if ([newSuperview isKindOfClass:[UITableView class]]) {
		tableView = (UITableView *)newSuperview;
	}
}

- (void)setUseAlternativeColor:(BOOL)inUseAlternativeColor
{
	useAlternativeColor = inUseAlternativeColor;
	[self.backgroundView setNeedsDisplay];
}
- (BOOL)useAlternativeColor
{
	return useAlternativeColor;
}

- (void)setNeedsDisplay
{
	[super setNeedsDisplay];
	[self.backgroundView setNeedsDisplay];
}

- (void)setFrame:(CGRect)frame
{
	[super setFrame:frame];
	[self.backgroundView setNeedsDisplay];
}

@end
