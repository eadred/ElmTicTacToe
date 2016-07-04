module GameLogic exposing (..)

import Cells.Models exposing (..)

type alias Play = {player:Player, row:Int, col:Int}

checkWinner : List Play -> Maybe Player
checkWinner plays = let winners = lift2 (playerHasLine plays) [X, O] (diagonalChecks ++ straightLineChecks) in
                    Maybe.oneOf winners

playerHasLine : List Play -> Player -> (Play -> Bool) -> Maybe Player
playerHasLine plays player isOnLine =
  let playsOnLine = List.filter (\p -> isOnLine p && p.player == player) plays in
  if List.length playsOnLine == 3 then Just player else Nothing

straightLineChecks : List (Play -> Bool)
straightLineChecks =
  let isOnStraightLine getLineIndex n play = (getLineIndex play) == n in
  lift2 isOnStraightLine [\p -> p.row, \p -> p.col] [0, 1, 2]

diagonalChecks : List (Play -> Bool)
diagonalChecks =
  let isOnDiag mapCol play = play.row == mapCol (play.col) in
  List.map isOnDiag [identity, invertRowCol]

invertRowCol : Int -> Int
invertRowCol rc =
  case rc of
    0 -> 2
    2 -> 0
    x -> x

lift2 : (a -> b -> c) -> List a -> List b -> List c
lift2 f aLst bLst =
  let b2cs = List.map f aLst -- List (b -> c)
      applyB b = List.map (\f' -> f' b) b2cs in -- b -> List c
  List.concatMap applyB bLst
