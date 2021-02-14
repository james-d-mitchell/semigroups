#############################################################################
##
#W  standard/conguniv.tst
#Y  Copyright (C) 2015                                      Michael Torpey
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##
gap> START_TEST("Semigroups package: standard/conguniv.tst");
gap> LoadPackage("semigroups", false);;

# Set info levels and user preferences
gap> SEMIGROUPS.StartTest();

# CongUnivTest1: No zero, non-simple
gap> S := Semigroup([Transformation([1, 3, 4, 1, 3, 7, 5]),
>                    Transformation([5, 7, 1, 6, 1, 7, 6])]);;
gap> uni := UniversalSemigroupCongruence(S);
<universal semigroup congruence over <transformation semigroup of degree 7 
 with 2 generators>>
gap> pairs := GeneratingPairsOfSemigroupCongruence(uni);;
gap> cong := SemigroupCongruence(S, pairs);;
gap> NrCongruenceClasses(cong);
1
gap> part := EquivalenceRelationPartition(uni);;
gap> Size(part);
1
gap> Set(part[1]) = Elements(S);
true

# CongUnivTest2: Has zero, not 0-simple
gap> S := Semigroup([Transformation([2, 4, 3, 5, 5, 7, 1]),
>                      Transformation([6, 2, 3, 3, 1, 5])]);;
gap> uni := UniversalSemigroupCongruence(S);;
gap> pairs := GeneratingPairsOfSemigroupCongruence(uni);;
gap> cong := SemigroupCongruence(S, pairs);;
gap> NrCongruenceClasses(cong);
1

# CongUnivTest3: Has zero, is 0-simple
gap> r := ReesZeroMatrixSemigroup(Group([(5, 6)]),
> [[0, (), 0, 0, 0, 0, 0, 0, 0, (5, 6), 0, 0, (5, 6), (5, 6)],
>   [(), 0, (), 0, (), (5, 6), 0, (5, 6), 0, 0, (5, 6), (5, 6), (5, 6), ()],
>   [0, 0, (), (5, 6), 0, 0, 0, (), 0, (5, 6), 0, 0, 0, (5, 6)],
>   [0, 0, 0, (5, 6), 0, (), (5, 6), (), 0, (5, 6), 0, (), 0, (5, 6)],
>   [0, (), (5, 6), 0, 0, 0, (5, 6), (5, 6), (), 0, (5, 6), (), (5, 6), 0],
>   [0, (), 0, (5, 6), 0, 0, (5, 6), 0, (), (5, 6), (5, 6), (), (5, 6), (5, 6)],
>   [0, (5, 6), 0, (5, 6), 0, (), (5, 6), (), 0, 0, 0, (), (), 0],
>   [(), 0, (), (5, 6), (), 0, (5, 6), 0, 0, (5, 6), (5, 6), 0, (5, 6), 0],
>   [0, (), 0, 0, 0, (5, 6), 0, (5, 6), (), 0, (5, 6), 0, (5, 6), 0],
>   [0, 0, (5, 6), 0, 0, (), (5, 6), 0, 0, 0, 0, (), 0, 0],
>   [0, (5, 6), (), (5, 6), 0, 0, 0, (), 0, 0, 0, 0, (), 0]]);;
gap> congs := CongruencesOfSemigroup(r);;
gap> uni := UniversalSemigroupCongruence(r);;
gap> uni = congs[3];
false
gap> congs[5] = uni;
false
gap> IsSubrelation(uni, congs[5]);
true
gap> IsSubrelation(congs[5], uni);
false
gap> otheruni := UniversalSemigroupCongruence(FullTransformationMonoid(5));;
gap> pairs := GeneratingPairsOfSemigroupCongruence(uni);;
gap> IsSubrelation(congs[4], otheruni);
Error, the ranges of the arguments (congruences) do not coincide
gap> IsSubrelation(otheruni, congs[4]);
Error, the ranges of the arguments (congruences) do not coincide
gap> cong := SemigroupCongruence(r, pairs);;
gap> NrCongruenceClasses(cong);
1

# CongUnivTest4: No zero, is simple
gap> S := Semigroup(
> [Transformation([1, 1, 1, 1, 5, 1, 1]),
>  Transformation([1, 5, 1, 1, 5, 1, 1]),
>  Transformation([3, 3, 3, 3, 5, 3, 3]),
>  Transformation([3, 5, 3, 3, 5, 3, 3]),
>  Transformation([4, 4, 4, 4, 5, 4, 4]),
>  Transformation([4, 5, 4, 4, 5, 4, 4]),
>  Transformation([6, 5, 6, 6, 5, 6, 6]),
>  Transformation([6, 6, 6, 6, 5, 6, 6]),
>  Transformation([7, 5, 7, 7, 5, 7, 7]),
>  Transformation([7, 7, 7, 7, 5, 7, 7])]);;
gap> uni := UniversalSemigroupCongruence(r);;
gap> pairs := GeneratingPairsOfSemigroupCongruence(uni);;
gap> cong := SemigroupCongruence(r, pairs);;
gap> NrCongruenceClasses(cong);
1

# EquivalenceRelationCanonicalLookup
gap> S := FullTransformationMonoid(2);;
gap> uni := UniversalSemigroupCongruence(S);;
gap> EquivalenceRelationCanonicalLookup(uni);
[ 1, 1, 1, 1 ]

# Equality checking
gap> S := FullTransformationMonoid(2);;
gap> T := Semigroup([Transformation([2, 3, 3])]);;
gap> uniS := UniversalSemigroupCongruence(S);;
gap> uniT := UniversalSemigroupCongruence(T);;
gap> uniS = uniT;
false
gap> uniS = UniversalSemigroupCongruence(S);
true
gap> cong := SemigroupCongruence(S, [Transformation([1, 1]),
>                                    Transformation([2, 2])]);;
gap> cong = uniS;
false
gap> cong := SemigroupCongruence(T, [Transformation([2, 3, 3]),
>                                    Transformation([3, 3, 3])]);;
gap> uniT = cong;
true

# Pair inclusion
gap> S := Semigroup([Transformation([1, 4, 2, 4])]);;
gap> uni := UniversalSemigroupCongruence(S);;
gap> [Transformation([1, 4, 2, 4]), Transformation([1, 4, 4, 4])] in uni;
true
gap> [Transformation([1, 3, 2, 4]), Transformation([1, 4, 4, 4])] in uni;
Error, the items in the 1st argument (a list) do not belong to the range of th\
e 2nd argument (a right semigroup congruence)
gap> [3, 4] in uni;
Error, the items in the 1st argument (a list) do not belong to the range of th\
e 2nd argument (a right semigroup congruence)
gap> [Transformation([1, 4, 2, 4])] in uni;
Error, the 1st argument (a list) does not have length 2

# Classes
gap> S := Semigroup([PartialPerm([1, 2], [3, 1]),
>                    PartialPerm([1, 2, 3], [1, 3, 4])]);
<partial perm semigroup of rank 3 with 2 generators>
gap> uni := UniversalSemigroupCongruence(S);;
gap> ImagesElm(uni, PartialPerm([1, 2, 3], [1, 3, 4])) = Elements(S);
true
gap> ImagesElm(uni, Transformation([1, 3, 2]));
Error, the 2nd argument (a mult. elt.) does not belong to the range of the 1st\
 argument (a congruence)
gap> classes := EquivalenceClasses(uni);
[ <congruence class of [2,1,3]> ]
gap> EquivalenceClassOfElement(uni, Transformation([1, 3, 2]));
Error, the 2nd argument (a mult. elt.) does not belong to the range of the 1st\
 argument (a congruence)
gap> class := EquivalenceClassOfElement(uni, PartialPerm([1, 2, 3], [1, 3, 4]));
<congruence class of [2,3,4](1)>
gap> PartialPerm([2], [3]) in class;
true
gap> PartialPerm([1, 2, 4], [3, 2, 1]) in class;
false
gap> classes[1] * class = class;
true
gap> class = classes[1];
true
gap> T := Semigroup([PartialPerm([1], [3]),
>                    PartialPerm([1, 2, 3], [1, 3, 4])]);;
gap> badcong := UniversalSemigroupCongruence(T);;
gap> class * EquivalenceClassOfElement(badcong, PartialPerm([1], [3]));
Error, the ranges of the arguments (congruences) do not coincide
gap> Size(class);
11

# Meet and join
gap> S := Semigroup([Transformation([1, 3, 4, 1]),
>                    Transformation([3, 1, 1, 3])]);;
gap> T := Semigroup([Transformation([1, 2, 4, 1]),
>                    Transformation([3, 3, 1, 3])]);;
gap> cong := SemigroupCongruence(S, [Transformation([1, 3, 1, 1]),
>                                    Transformation([1, 3, 4, 1])]);;
gap> uni := UniversalSemigroupCongruence(S);;
gap> uni = JoinSemigroupCongruences(uni, uni);
true
gap> uni = JoinSemigroupCongruences(cong, uni);
true
gap> uni = JoinSemigroupCongruences(uni, cong);
true
gap> uni = MeetSemigroupCongruences(uni, uni);
true
gap> cong = MeetSemigroupCongruences(cong, uni);
true
gap> cong = MeetSemigroupCongruences(uni, cong);
true
gap> badcong := SemigroupCongruence(T, [Transformation([1, 2, 4, 1]),
>                                       Transformation([1, 1, 1, 1])]);;
gap> JoinSemigroupCongruences(uni, badcong);
Error, the ranges of the arguments (congruences) do not coincide
gap> JoinSemigroupCongruences(badcong, uni);
Error, the ranges of the arguments (congruences) do not coincide
gap> MeetSemigroupCongruences(uni, badcong);
Error, the ranges of the arguments (congruences) do not coincide
gap> MeetSemigroupCongruences(badcong, uni);
Error, the ranges of the arguments (congruences) do not coincide
gap> cong := SemigroupCongruence(S, [Transformation([1, 3, 4, 1]),
>                                    Transformation([1, 3, 3, 1])]);;
gap> cong = uni;
true

# GeneratingPairsOfSemigroupCongruence
gap> S := Semigroup(IdentityTransformation);
<trivial transformation group of degree 0 with 1 generator>
gap> uni := UniversalSemigroupCongruence(S);;
gap> GeneratingPairsOfSemigroupCongruence(uni);
[  ]
gap> S := Semigroup([Transformation([4, 5, 3, 4, 5]),
>                    Transformation([5, 1, 3, 1, 5])]);;
gap> uni := UniversalSemigroupCongruence(S);;
gap> GeneratingPairsOfSemigroupCongruence(uni);
[ [ Transformation( [ 4, 5, 3, 4, 5 ] ), Transformation( [ 5, 5, 3, 5, 5 ] ) 
     ] ]
gap> S := Monoid([PartialPerm([1], [1]),
>                 PartialPerm([1, 2], [1, 2]),
>                 PartialPerm([1], [1])]);;
gap> uni := UniversalSemigroupCongruence(S);;
gap> GeneratingPairsOfSemigroupCongruence(uni);
[ [ <identity partial perm on [ 1 ]>, <identity partial perm on [ 1, 2 ]> ] ]
gap> S := Semigroup([Transformation([2, 1, 2]),
>                    Transformation([1, 2, 2])]);;
gap> uni := UniversalSemigroupCongruence(S);
<universal semigroup congruence over <transformation semigroup of degree 3 
 with 2 generators>>
gap> pairs := GeneratingPairsOfSemigroupCongruence(uni);;
gap> cong := SemigroupCongruenceByGeneratingPairs(S, pairs);;
gap> NrCongruenceClasses(cong);
1

# IsUniversalSemigroupCongruence for a cong by generating pairs
gap> S := Semigroup([PartialPerm([1], [2]),
>                    PartialPerm([1, 2, 3], [2, 3, 1])]);;
gap> cong := SemigroupCongruence(S, [PartialPerm([1], [1]),
>                                    PartialPerm([1, 2, 3], [3, 1, 2])]);;
gap> IsUniversalSemigroupCongruence(cong);
true
gap> cong := SemigroupCongruence(S, [PartialPerm([1], [2]),
>                                    PartialPerm([1], [3])]);;
gap> IsUniversalSemigroupCongruence(cong);
false

# IsUniversalSemigroupCongruence for an RMS congruence
gap> S := ReesMatrixSemigroup(SymmetricGroup(4),
>                             [[(), (), (), ()],
>                              [(2, 4), (), (1, 3), ()],
>                              [(1, 2, 3, 4), (), (1, 3, 2, 4), ()]]);;
gap> cong := RMSCongruenceByLinkedTriple(S, Group([(2, 4, 3),
>                                                  (1, 4)(2, 3),
>                                                  (1, 3)(2, 4)]),
>                                        [[1], [2], [3], [4]], [[1], [2, 3]]);;
gap> IsUniversalSemigroupCongruence(cong);
false
gap> cong := RMSCongruenceByLinkedTriple(S, SymmetricGroup(4),
>                                        [[1, 2, 3, 4]], [[1, 2, 3]]);;
gap> IsUniversalSemigroupCongruence(cong);
true

# SEMIGROUPS_UnbindVariables
gap> Unbind(S);
gap> Unbind(T);
gap> Unbind(badcong);
gap> Unbind(class);
gap> Unbind(classes);
gap> Unbind(cong);
gap> Unbind(congs);
gap> Unbind(otheruni);
gap> Unbind(pairs);
gap> Unbind(r);
gap> Unbind(uni);
gap> Unbind(uniS);
gap> Unbind(uniT);

#
gap> SEMIGROUPS.StopTest();
gap> STOP_TEST("Semigroups package: standard/conguniv.tst");
