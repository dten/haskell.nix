{pkgs, evalPackages, ghc}:
evalPackages.writeTextFile {
  name = "supported-languages";
  text = ''
Haskell98
Haskell2010
GHC2021
Unsafe
Trustworthy
Safe
AllowAmbiguousTypes
NoAllowAmbiguousTypes
AlternativeLayoutRule
NoAlternativeLayoutRule
AlternativeLayoutRuleTransitional
NoAlternativeLayoutRuleTransitional
Arrows
NoArrows
AutoDeriveTypeable
NoAutoDeriveTypeable
BangPatterns
NoBangPatterns
BinaryLiterals
NoBinaryLiterals
CApiFFI
NoCApiFFI
CPP
NoCPP
CUSKs
NoCUSKs
ConstrainedClassMethods
NoConstrainedClassMethods
ConstraintKinds
NoConstraintKinds
DataKinds
NoDataKinds
DatatypeContexts
NoDatatypeContexts
DefaultSignatures
NoDefaultSignatures
DeriveAnyClass
NoDeriveAnyClass
DeriveDataTypeable
NoDeriveDataTypeable
DeriveFoldable
NoDeriveFoldable
DeriveFunctor
NoDeriveFunctor
DeriveGeneric
NoDeriveGeneric
DeriveLift
NoDeriveLift
DeriveTraversable
NoDeriveTraversable
DerivingStrategies
NoDerivingStrategies
DerivingVia
NoDerivingVia
DisambiguateRecordFields
NoDisambiguateRecordFields
DoAndIfThenElse
NoDoAndIfThenElse
BlockArguments
NoBlockArguments
DoRec
NoDoRec
DuplicateRecordFields
NoDuplicateRecordFields
FieldSelectors
NoFieldSelectors
EmptyCase
NoEmptyCase
EmptyDataDecls
NoEmptyDataDecls
EmptyDataDeriving
NoEmptyDataDeriving
ExistentialQuantification
NoExistentialQuantification
ExplicitForAll
NoExplicitForAll
ExplicitNamespaces
NoExplicitNamespaces
ExtendedDefaultRules
NoExtendedDefaultRules
ExtendedLiterals
NoExtendedLiterals
FlexibleContexts
NoFlexibleContexts
FlexibleInstances
NoFlexibleInstances
ForeignFunctionInterface
NoForeignFunctionInterface
FunctionalDependencies
NoFunctionalDependencies
GADTSyntax
NoGADTSyntax
GADTs
NoGADTs
GHCForeignImportPrim
NoGHCForeignImportPrim
GeneralizedNewtypeDeriving
NoGeneralizedNewtypeDeriving
GeneralisedNewtypeDeriving
NoGeneralisedNewtypeDeriving
ImplicitParams
NoImplicitParams
ImplicitPrelude
NoImplicitPrelude
ImportQualifiedPost
NoImportQualifiedPost
ImpredicativeTypes
NoImpredicativeTypes
IncoherentInstances
NoIncoherentInstances
TypeFamilyDependencies
NoTypeFamilyDependencies
InstanceSigs
NoInstanceSigs
ApplicativeDo
NoApplicativeDo
InterruptibleFFI
NoInterruptibleFFI
NoJavaScriptFFI
KindSignatures
NoKindSignatures
LambdaCase
NoLambdaCase
LexicalNegation
NoLexicalNegation
LiberalTypeSynonyms
NoLiberalTypeSynonyms
LinearTypes
NoLinearTypes
MagicHash
NoMagicHash
MonadComprehensions
NoMonadComprehensions
MonoLocalBinds
NoMonoLocalBinds
DeepSubsumption
NoDeepSubsumption
MonomorphismRestriction
NoMonomorphismRestriction
MultiParamTypeClasses
NoMultiParamTypeClasses
MultiWayIf
NoMultiWayIf
NumericUnderscores
NoNumericUnderscores
NPlusKPatterns
NoNPlusKPatterns
NamedFieldPuns
NoNamedFieldPuns
NamedWildCards
NoNamedWildCards
NegativeLiterals
NoNegativeLiterals
HexFloatLiterals
NoHexFloatLiterals
NondecreasingIndentation
NoNondecreasingIndentation
NullaryTypeClasses
NoNullaryTypeClasses
NumDecimals
NoNumDecimals
OverlappingInstances
NoOverlappingInstances
OverloadedLabels
NoOverloadedLabels
OverloadedLists
NoOverloadedLists
OverloadedStrings
NoOverloadedStrings
PackageImports
NoPackageImports
ParallelArrays
NoParallelArrays
ParallelListComp
NoParallelListComp
PartialTypeSignatures
NoPartialTypeSignatures
PatternGuards
NoPatternGuards
PatternSignatures
NoPatternSignatures
PatternSynonyms
NoPatternSynonyms
PolyKinds
NoPolyKinds
PolymorphicComponents
NoPolymorphicComponents
QuantifiedConstraints
NoQuantifiedConstraints
PostfixOperators
NoPostfixOperators
QuasiQuotes
NoQuasiQuotes
QualifiedDo
NoQualifiedDo
Rank2Types
NoRank2Types
RankNTypes
NoRankNTypes
RebindableSyntax
NoRebindableSyntax
OverloadedRecordDot
NoOverloadedRecordDot
OverloadedRecordUpdate
NoOverloadedRecordUpdate
RecordPuns
NoRecordPuns
RecordWildCards
NoRecordWildCards
RecursiveDo
NoRecursiveDo
RelaxedLayout
NoRelaxedLayout
RelaxedPolyRec
NoRelaxedPolyRec
RoleAnnotations
NoRoleAnnotations
ScopedTypeVariables
NoScopedTypeVariables
StandaloneDeriving
NoStandaloneDeriving
StarIsType
NoStarIsType
StaticPointers
NoStaticPointers
Strict
NoStrict
StrictData
NoStrictData
TemplateHaskell
NoTemplateHaskell
TemplateHaskellQuotes
NoTemplateHaskellQuotes
StandaloneKindSignatures
NoStandaloneKindSignatures
TraditionalRecordSyntax
NoTraditionalRecordSyntax
TransformListComp
NoTransformListComp
TupleSections
NoTupleSections
TypeAbstractions
NoTypeAbstractions
TypeApplications
NoTypeApplications
TypeData
NoTypeData
TypeInType
NoTypeInType
TypeFamilies
NoTypeFamilies
TypeOperators
NoTypeOperators
TypeSynonymInstances
NoTypeSynonymInstances
UnboxedTuples
NoUnboxedTuples
UnboxedSums
NoUnboxedSums
UndecidableInstances
NoUndecidableInstances
UndecidableSuperClasses
NoUndecidableSuperClasses
UnicodeSyntax
NoUnicodeSyntax
UnliftedDatatypes
NoUnliftedDatatypes
UnliftedFFITypes
NoUnliftedFFITypes
UnliftedNewtypes
NoUnliftedNewtypes
ViewPatterns
NoViewPatterns
'';
}