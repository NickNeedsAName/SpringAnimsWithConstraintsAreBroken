# SpringAnimsWithConstraintsAreBroken
Spring Animations With Constraints are Broken

This is a simple app to demonstrate an issue with constraint-based layouts + spring animations.  

A subview (bordered in red) is constrained inside it's superview (bordered in blue) to have a fixed aspect ratio, centered on x+y, and initially an equal width.  Additionally, and at a higher priority than the 'width' constraint, the view should also always be taller and wider.

The superview is then animated from an aspect ratio != subview fixed aspect ratio -> subview aspect ratio.  The spring animation is exaggerated to highlight the effect.  

You would expect to see the red view maintain it's aspect ratio, but always be taller and wider than the blue view.  It does not.  Addtionally, there are no warnings, errors, or anything of that nature indicating that UIKit is ignoring some constraints that usually come along with UIKit ignoring constraints.
