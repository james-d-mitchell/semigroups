#############################################################################
##
##  semipperm.gd
##  Copyright (C) 2013-15                                James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

DeclareAttribute("DigraphOfActionOnPoints", IsPartialPermSemigroup);
DeclareOperation("DigraphOfActionOnPoints",
                 [IsPartialPermSemigroup, IsInt]);

DeclareAttribute("FixedPointsOfPartialPermSemigroup",
                 IsPartialPermSemigroup);
DeclareAttribute("CyclesOfPartialPermSemigroup",
                 IsPartialPermSemigroup);
DeclareAttribute("ComponentRepsOfPartialPermSemigroup",
                 IsPartialPermSemigroup);
DeclareAttribute("ComponentsOfPartialPermSemigroup",
                 IsPartialPermSemigroup);

DeclareAttribute("SmallerDegreePartialPermRepresentation",
                 IsInverseSemigroup and IsPartialPermSemigroup);
