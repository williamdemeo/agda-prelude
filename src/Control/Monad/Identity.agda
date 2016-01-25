
module Control.Monad.Identity where

open import Prelude
open import Data.Foldable
open import Data.Traversable

record Identity {a} (A : Set a) : Set a where
  constructor mkIdentity
  field
    runIdentity : A

open Identity public

instance
  MonadId : ∀ {a} → Monad (Identity {a})
  runIdentity (return {{MonadId}} x) = x
  _>>=_ {{MonadId}} m f = f (runIdentity m)

  PMonadId : ∀ {a b} → PMonad {a} {b} Identity
  _>>=′_ {{PMonadId}} m f = f (runIdentity m)

  ApplicativeId : ∀ {a} → Applicative (Identity {a})
  ApplicativeId = defaultMonadApplicative

  FunctorId : ∀ {a} → Functor (Identity {a})
  FunctorId = defaultMonadFunctor

  FoldableId : ∀ {a w} → Foldable {w = w} (Identity {a})
  foldMap {{FoldableId}} f m = f (runIdentity m)

  TraversableId : ∀ {a} → Traversable (Identity {a})
  traverse {{TraversableId}} f m = pure mkIdentity <*> f (runIdentity m)
