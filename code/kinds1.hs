{-# LANGUAGE DataKinds #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE PolyKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE GADTs #-}

module KindsExamples where

import Data.Kind (Type, Constraint)

--------------------------------------------------------------------------------
-- 1) Plain types have kind Type
--------------------------------------------------------------------------------

x :: Int
x = 42

-- In GHCi:
-- :k Int
-- Int :: Type
-- :k Bool
-- Bool :: Type


--------------------------------------------------------------------------------
-- 2) Type constructors have arrow kinds
--------------------------------------------------------------------------------

-- Maybe takes a Type and returns a Type
-- In GHCi:
-- :k Maybe
-- Maybe :: Type -> Type

maybeInt :: Maybe Int
maybeInt = Just 1

-- Either takes two Types
-- :k Either
-- Either :: Type -> Type -> Type


--------------------------------------------------------------------------------
-- 3) Higher-kinded types (type constructors that take type constructors)
--------------------------------------------------------------------------------

-- Functor expects something of kind Type -> Type
-- :k Functor
-- Functor :: (Type -> Type) -> Constraint

-- This is OK:
f1 :: Maybe Int
f1 = fmap (+1) (Just 10)

-- This would be rejected (uncomment to see the error):
-- badFunctor :: Int
-- badFunctor = fmap (+1) 10
-- because Int is not of kind Type -> Type


--------------------------------------------------------------------------------
-- 4) Writing kind signatures explicitly
--------------------------------------------------------------------------------

-- A type constructor with an explicit kind:
data Box (a :: Type) = Box a

-- :k Box
-- Box :: Type -> Type

-- A "higher-kinded" container: it takes a type constructor f
newtype Wrap (f :: Type -> Type) (a :: Type) = Wrap (f a)

-- :k Wrap
-- Wrap :: (Type -> Type) -> Type -> Type


--------------------------------------------------------------------------------
-- 5) Constraint is a kind (typeclass constraints live there)
--------------------------------------------------------------------------------

type Showish :: Type -> Constraint
type Showish a = (Show a)

-- :k Showish
-- Showish :: Type -> Constraint


--------------------------------------------------------------------------------
-- 6) DataKinds: promoting values to the type level introduces new kinds
--------------------------------------------------------------------------------

-- A value-level datatype:
data Color = Red | Green | Blue

-- With DataKinds, the *type-level* constructors 'Red, 'Green, 'Blue exist.
-- And the *kind* Color exists too.

-- :k Color
-- Color :: Type
-- :k 'Red
-- 'Red :: Color

-- Using that kind in a type:
data Paint (c :: Color) = Paint

redPaint :: Paint 'Red
redPaint = Paint


--------------------------------------------------------------------------------
-- 7) PolyKinds: parameters can range over ANY kind, not just Type
--------------------------------------------------------------------------------

-- Proxy generalized by PolyKinds:
data Proxy (a :: k) = Proxy
-- :k Proxy
-- Proxy :: forall k. k -> Type

p1 :: Proxy Int
p1 = Proxy

p2 :: Proxy 'Red
p2 = Proxy


--------------------------------------------------------------------------------
-- 8) GADTs + kind-indexed types (a common reason you care about kinds)
--------------------------------------------------------------------------------

data Nat = Z | S Nat

-- 'Nat is a kind at the type level; 'Z and 'S are type-level constructors.
data Vec :: Nat -> Type -> Type where
  VNil  :: Vec 'Z a
  VCons :: a -> Vec n a -> Vec ('S n) a

-- Vec has kind:
-- :k Vec
-- Vec :: Nat -> Type -> Type

v0 :: Vec 'Z Int
v0 = VNil

v1 :: Vec ('S 'Z) Int
v1 = VCons 7 VNil