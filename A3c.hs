module A3c where
import Data.Char
import Data.Maybe

onlyLowercase::[[Char]] -> [[Char]]
onlyLowercase [] = []
onlyLowercase (x:xs) =
  filter (\(c:cs) -> isLower c) (x:xs)

longestString::[String] -> String
longestString [] = ""
longestString (x:xs) =
  foldl (\a b -> if((length b) > (length a)) then b else a) "" (x:xs)


longestString'::[String] -> String
longestString' [] = ""
longestString' (x:xs) =
  foldl (\a b -> if((length b) >= (length a)) then b else a) "" (x:xs)

longestString3::[String] -> String
longestString3 [] = ""
longestString3 (x:xs) =
  longestStringHelper (>) (x:xs)

longestString4::[String] -> String
longestString4 [] = ""
longestString4 (x:xs) =
  longestStringHelper (>=) (x:xs)

longestStringHelper:: (Int -> Int -> Bool) -> [String] -> String
longestStringHelper f (x:xs) =
  foldl (\a b -> if(f (length b) (length a)) then b else a) "" (x:xs)


longestLowerCase:: [String] -> String
longestLowerCase [] = ""
longestLowerCase (x:xs) =
  (longestString . onlyLowercase) (x:xs)

revStringRev:: String -> String
revStringRev "" = ""
revStringRev (x:xs) =
  (reverse . revStringHelper) (x:xs)

revStringHelper [] = []
revStringHelper (x:xs)
  | isLower x = (toUpper x) : revStringHelper xs
  |otherwise = (toLower x) : revStringHelper xs

firstAnswer:: (a->Maybe b) -> [a] -> Maybe b
firstAnswer _ [] = Nothing
firstAnswer p (x:xs) =
  if(isJust (p x)) then (p x) else firstAnswer p xs

--no fucking clue
--allAnswers::(a->Maybe [b]) -> [a] -> Maybe [b]
--allAnswers _ [] = []
--allAnswers p (x:xs) =
  --if(isJust (p x)) then (Just (p x))++(allAnswers p xs) else Nothing

--allAnswersHelper a acc

data Pattern = WildcardPat | VariablePat (String) | UnitPat | ConstantPat (Int) | ConstructorPat (String, Pattern) | TuplePat ([Pattern]) deriving (Eq, Show)
data Value = Constant (Int) | Unit | Constructor (String, Value) | Tuple [Value] deriving (Eq, Show)

--applies f1 if given WildCardPats which takes an empty tuple and returns an a
--applies f2 to x if given variable pat which takes a string and returns an a
--If given a constructor pattern it recalls g with the pattern in the constructor
--if given a tuple pattern it returns the foldl of g with all the patterns in
--the tuple, ads the accumulator to it
--anything else it returns 0

--g takes a pattern and returns a value
g f1 f2 pat =
 let
   r = g f1 f2
 in
   case pat of
     WildcardPat -> f1 ()
     VariablePat x -> f2 x
     ConstructorPat (_, p) -> r p
     TuplePat values -> foldl (\i p -> (r p) + i) 0 values
     _ -> 0


countWildcards:: Pattern -> Int
countWildcards p = g (\ x -> 1) (\x -> 0) p

countWildAndVariableLengths:: Pattern -> Int
countWildAndVariableLengths p = g (\ x -> 1) (length) p

countAVar:: (String, Pattern) -> Int
countAVar (s, p) = g (\x -> 0) (\x -> if(s == x) then 1 else 0) p

--no fucking clue
--checkPat:: Pattern -> Boolean
--checkPat p =
--
--checkPatHelperStringList:: Pattern -> [String]
--checkPatHelperStringList p =
--
--no fucking clue
--match:: (Value, Pattern) -> Maybe [(String, Value)]
--match(_, WildcardPattern) = Nothing
--match(v, (VariablePat s)) = Just [(s, v)]
--match((Unit), (UnitPat)) = Just [(s, v)]
--match((Constant v), (ConstantPat v2)) = if (v == v2) then Just [] else Nothing
--match((Tuple (v:vs)), (TuplePat (p:ps))) = Just

--firstMatch to afraid to try 