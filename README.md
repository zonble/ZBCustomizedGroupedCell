ZBCustomizedGroupedCell
=======================

A legacy Objective-C library for iOS that provides customized drawing of `UITableViewCell` backgrounds for both plain and grouped table view styles.

> **Note about naming:** The source files and class are spelled `ZBCusomizedTableViewCell` (missing the letter **t**), which is a typo that was present in the original code. The examples in this document use the actual misspelled names so that the code compiles without modification.

> **Note:** This is a legacy project written in Objective-C with Manual Reference Counting (MRC/non-ARC), targeting iOS 6.0. It is no longer actively maintained but is preserved here for reference.

## Features

- Custom-drawn cell backgrounds using `UIBezierPath` and Core Graphics
- Proper rounded corners for first, last, and single-row cells in grouped table views
- Alternating row background colors (white and light gray)
- Custom selected-state background (red highlight by default)
- Works with both `UITableViewStylePlain` and `UITableViewStyleGrouped`

## Requirements

- iOS 6.0+
- Xcode 4.x or later
- Objective-C (Manual Reference Counting)

## Installation

There is no CocoaPods podspec or Swift Package Manager support. To use this library, copy the following files directly into your Xcode project:

- `Sample/ZBCusomizedTableViewCell.h`
- `Sample/ZBCusomizedTableViewCell.m`

Make sure your target links against the **QuartzCore** framework.

## Usage

Import the header and use `ZBCusomizedTableViewCell` in place of `UITableViewCell` in your table view data source:

```objc
#import "ZBCusomizedTableViewCell.h"

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";

    ZBCusomizedTableViewCell *cell = (ZBCusomizedTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[ZBCusomizedTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                               reuseIdentifier:CellIdentifier] autorelease];
    }

    // Alternate background colors between rows
    cell.useAlternativeColor = (BOOL)(indexPath.row % 2);
    cell.textLabel.text = @"Hello, world!";

    return cell;
}
```

## API

### `ZBCusomizedTableViewCell`

A `UITableViewCell` subclass that draws custom backgrounds.

| Property | Type | Description |
|----------|------|-------------|
| `useAlternativeColor` | `BOOL` | When `YES`, the cell background uses white; when `NO`, it uses light gray. Defaults to `NO`. |

The cell automatically detects whether it is inside a `UITableViewStylePlain` or `UITableViewStyleGrouped` table view and renders accordingly.

## Sample Project

Open `Sample.xcodeproj` in Xcode to run the included sample application. It demonstrates a grouped table view with 10 rows using alternating background colors.

## License

No explicit license is provided in this repository. Please contact the original author for licensing information.