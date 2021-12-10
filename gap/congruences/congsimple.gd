############################################################################
##
##  congruences/congsimple.gd
##  Copyright (C) 2015-2021                               Michael C. Young
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##
## This file contains methods for congruences on finite (0-)simple semigroups,
## using isomorphisms to Rees (0-)matrix semigroups and methods in
## congruences/reesmat.gd/gi.

DeclareCategory("IsSimpleSemigroupCongruence",
                IsCongruenceCategory and IsAttributeStoringRep and IsFinite);

DeclareCategory("IsSimpleSemigroupCongruenceClass",
                IsAnyCongruenceClass and IsCongruenceClass and
                IsAttributeStoringRep and IsAssociativeElement);

DeclareOperation("CongruenceByIsomorphism",
[IsGeneralMapping, IsSemigroupCongruence]);
