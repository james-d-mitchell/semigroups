#############################################################################
##
##  dual.gi
##  Copyright (C) 2018-2021                                 James D. Mitchell
##                                                          Finn Smith
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

# This file contains an implementation of dual semigroups. We only provide
# enough functionality to allow dual semigroups to work as semigroups. This is
# to avoid having to install versions of every function in Semigroups specially
# for dual semigroup representations. In some cases special functions would be
# faster.

InstallMethod(DualSemigroup, "for a semigroup",
[IsSemigroup],
function(S)
  local dual, fam, filts, map, type;

  if IsDualSemigroupRep(S) then
    if HasGeneratorsOfSemigroup(S) then
      return Semigroup(List(GeneratorsOfSemigroup(S),
                            x -> UnderlyingElementOfDualSemigroupElement(x)));
    fi;
    ErrorNoReturn("this dual semigroup cannot be constructed ",
                  "without knowing generators");
  fi;

  fam   := NewFamily("DualSemigroupElementsFamily", IsDualSemigroupElement);
  dual  := Objectify(NewType(CollectionsFamily(fam),
                            IsSemigroup and
                            IsWholeFamily and
                            IsDualSemigroupRep and
                            IsAttributeStoringRep),
                    rec());

  filts := IsDualSemigroupElement;
  if IsMultiplicativeElementWithOne(Representative(S)) then
    filts := filts and IsMultiplicativeElementWithOne;
  fi;

  type       := NewType(fam, filts);
  fam!.type  := type;

  SetDualSemigroupOfFamily(fam, dual);

  SetElementsFamily(FamilyObj(dual), fam);
  SetDualSemigroup(dual, S);

  if HasIsFinite(S) then
    SetIsFinite(dual, IsFinite(S));
  fi;

  if IsTransformationSemigroup(S) then
    map := AntiIsomorphismDualSemigroup(dual);
    SetAntiIsomorphismTransformationSemigroup(dual, map);
  fi;

  if HasGeneratorsOfSemigroup(S) then
    SetGeneratorsOfSemigroup(dual,
                             List(GeneratorsOfSemigroup(S),
                                  x -> SEMIGROUPS.DualSemigroupElementNC(dual,
                                                                         x)));
  fi;

  if HasGeneratorsOfMonoid(S) then
    SetGeneratorsOfMonoid(dual,
                          List(GeneratorsOfMonoid(S),
                               x -> SEMIGROUPS.DualSemigroupElementNC(dual,
                                                                      x)));
  fi;
  return dual;
end);

SEMIGROUPS.DualSemigroupElementNC := function(S, s)
  if not IsDualSemigroupElement(s) then
    return Objectify(ElementsFamily(FamilyObj(S))!.type, [s]);
  fi;
  return s![1];
end;

InstallMethod(AntiIsomorphismDualSemigroup, "for a semigroup",
[IsSemigroup],
function(S)
  local dual, inv, iso;

  dual := DualSemigroup(S);
  iso  := function(x)
    return SEMIGROUPS.DualSemigroupElementNC(dual, x);
  end;

  inv := function(x)
    return SEMIGROUPS.DualSemigroupElementNC(S, x);
  end;
  return MappingByFunction(S, dual, iso, inv);
end);

InstallGlobalFunction(UnderlyingElementOfDualSemigroupElement,
function(s)
  if not IsDualSemigroupElement(s) then
    ErrorNoReturn("the argument is not an element represented as a dual ",
                  "semigroup element");
  fi;
  return s![1];
end);

################################################################################
## Technical methods
################################################################################

InstallMethod(OneMutable, "for a dual semigroup element",
[IsDualSemigroupElement and IsMultiplicativeElementWithOne],
function(s)
  local S, x;
  S := DualSemigroupOfFamily(FamilyObj(s));
  x := SEMIGROUPS.DualSemigroupElementNC(DualSemigroup(S), s);
  return SEMIGROUPS.DualSemigroupElementNC(S, OneMutable(x));
end);

# TODO(now): remove Other
InstallOtherMethod(MultiplicativeNeutralElement, "for a dual semigroup",
[IsDualSemigroupRep],
10,  # add rank to beat enumeration methods
function(S)
  local m;
  m := MultiplicativeNeutralElement(DualSemigroup(S));
  if m <> fail then
    return SEMIGROUPS.DualSemigroupElementNC(S, m);
  fi;
  return fail;
end);

InstallMethod(Representative, "for a dual semigroup",
[IsDualSemigroupRep],
function(S)
  if HasGeneratorsOfSemigroup(S) then
    return GeneratorsOfSemigroup(S)[1];
  fi;
  return SEMIGROUPS.DualSemigroupElementNC(S, Representative(DualSemigroup(S)));
end);

InstallMethod(Size, "for a dual semigroup",
[IsDualSemigroupRep],
10,  # add rank to beat enumeration methods
function(S)
  return Size(DualSemigroup(S));
end);

InstallMethod(AsList, "for a dual semigroup",
[IsDualSemigroupRep],
10,  # add rank to beat enumeration methods
function(S)
  return List(DualSemigroup(S), s -> SEMIGROUPS.DualSemigroupElementNC(S, s));
end);

InstallMethod(\*, "for dual semigroup elements",
IsIdenticalObj,
[IsDualSemigroupElement, IsDualSemigroupElement],
function(x, y)
  return Objectify(FamilyObj(x)!.type, [y![1] * x![1]]);
end);

InstallMethod(\=, "for dual semigroup elements",
IsIdenticalObj,
[IsDualSemigroupElement, IsDualSemigroupElement],
function(x, y)
  return x![1] = y![1];
end);

InstallMethod(\<, "for dual semigroup elements",
IsIdenticalObj,
[IsDualSemigroupElement, IsDualSemigroupElement],
function(x, y)
  return x![1] < y![1];
end);

InstallMethod(ViewObj, "for dual semigroup elements",
[IsDualSemigroupElement], PrintObj);

InstallMethod(PrintObj, "for dual semigroup elements",
[IsDualSemigroupElement],
function(x)
  Print("<", ViewString(x![1]), " in the dual semigroup>");
end);

InstallMethod(ViewObj, "for a dual semigroup",
[IsDualSemigroupRep], PrintObj);

InstallMethod(PrintObj, "for a dual semigroup",
[IsDualSemigroupRep],
function(S)
  Print("<dual semigroup of ",
        ViewString(DualSemigroup(S)),
        ">");
end);

InstallMethod(ChooseHashFunction, "for a dual semigroup element and int",
[IsDualSemigroupElement, IsInt],
function(x, data)
  local H, hashfunc;

  H        := ChooseHashFunction(x![1], data);
  hashfunc := function(a, b)
    return H.func(a![1], b);
  end;
  return rec(func := hashfunc, data := H.data);
end);
