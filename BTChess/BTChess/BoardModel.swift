//
//  BoardModel.swift
//  BTChess
//
//  Created by Michael Tang on 9/24/17.
//  Copyright © 2017 Michael Tang. All rights reserved.
//

import Foundation

class Moves{
    var row:Int
    var col:Int
    init(row:Int, col:Int){
        self.row = row
        self.col = col
    }
}

class Piece{
    var color: Bool
    var row: Int
    var col: Int
    //Abstract this method to the children
    func avalibleMoves() -> [Moves]{
        return [Moves(row: -1, col: -1)]
    }
    init(color: Bool, row: Int, col: Int) {
        self.color = color
        self.row = row
        self.col = col
    }
}

var Board: [[Piece?]] = Array(repeating: Array(repeating: nil, count:8), count: 8)

class Pawn: Piece{
    override init(color:Bool, row:Int, col: Int) {
        super.init(color: color, row: row, col: col)
    }
    override func avalibleMoves() -> [Moves] {
        var collection:[Moves] = []
        //White pawn
        if !self.color {
            //Pawn's first move
            if self.row == 1 && Board[self.row+1][self.col] == nil && Board[self.row+2][self.col] == nil {
                collection.append(Moves(row: self.row+2,col: self.col))
            }
            //forward square
            if self.row < 7 && Board[self.row+1][col] == nil{
                collection.append(Moves(row: self.row+1, col: self.col))
            }
            //Capture square left
            if self.col > 0 && self.row < 7 && Board[self.row+1][self.col-1] != nil && (Board[self.row+1][self.col-1]!.color) != self.color {
                collection.append(Moves(row: self.row+1, col: self.row-1))
            }
            //Capture square right
            if self.col < 7 && self.row < 7 && Board[self.row+1][self.col+1] != nil && (Board[self.row+1][self.col+1]!.color) != self.color {
                collection.append(Moves(row: self.row+1, col: self.row+1))
            }
            
            //Work on En passant

        }else{
            //Black pawn
            //Pawn's first move
            if self.row == 6 && Board[self.row-1][self.col] == nil && Board[self.row-2][self.col] == nil {
                collection.append(Moves(row: self.row-2,col: self.col))
            }
            //forward square
            if self.row > 0 && Board[self.row-1][col] == nil{
                collection.append(Moves(row: self.row-1, col: self.col))
            }
            //Capture square left
            if self.row > 0 && self.col > 0 && Board[self.row-1][self.col-1] != nil && (Board[self.row+1][self.col-1]!.color) != self.color {
                collection.append(Moves(row: self.row-1, col: self.col-1))
            }
            //Capture square right
            if self.row > 0 && self.col < 7 && Board[self.row-1][self.col+1] != nil && (Board[self.row-1][self.col+1]!.color) != self.color {
                collection.append(Moves(row: self.row-1, col: self.col+1))
            }
        }
        return collection
    }
}

class Knight: Piece{
    override init(color:Bool, row:Int, col: Int) {
        super.init(color: color, row: row, col: col)
    }
    override func avalibleMoves() -> [Moves] {
        var collection:[Moves] = []
        //1st octal
        if self.row+2<8 && self.col+1 < 8{
            let p:Piece? = Board[self.row+2][self.col+1]
            if p == nil || p!.color != self.color{
                collection.append(Moves(row: self.row+2, col: self.col+1))
            }
        }
        //2nd octal
        if self.row+1<8 && self.col+2 < 8 {
            let p:Piece? = Board[self.row+1][self.col+2]
            if p == nil || p!.color != self.color{
                collection.append(Moves(row: self.row+1, col: self.col+2))
            }
        }
        //3rd octal
        if self.row-1 >= 0 && self.col+2 < 8 {
            let p:Piece? = Board[self.row-1][self.col+2]
            if p == nil || p!.color != self.color {
                collection.append(Moves(row: self.row-1, col: self.col+2))
            }
        }
        //4th octal
        if self.row-2>=0 && self.col+1 < 8 {
            let p:Piece? = Board[self.row-2][self.col+1]
            if p == nil || p!.color != self.color{
                collection.append(Moves(row: self.row-2, col: self.col+1))
            }
        }
        //5th octal
        if self.row-2 >= 0 && self.col-1 >= 0 {
            let p:Piece? = Board[self.row-2][self.col-1]
            if p == nil || p!.color != self.color{
                collection.append(Moves(row: self.row-2, col: self.col-1))
            }
        }
        //6th octal
        if self.row-1 >= 0 && self.col-2 >= 0 {
            let p:Piece? = Board[self.row-1][self.col-2]
            if p == nil || p!.color != self.color{
                collection.append(Moves(row: self.row-1, col: self.col-2))
            }
        }
        //7th octal
        if self.row+1<8 && self.col-2 >= 0 {
            let p:Piece? = Board[self.row+1][self.col-2]
            if p == nil || p!.color != self.color{
                collection.append(Moves(row: self.row+1, col: self.col-2))
            }
        }
        //8th octal
        if self.row+2<8 && self.col-1 >= 0 {
            let p:Piece? = Board[self.row+2][self.col-1]
            if p == nil || p!.color != self.color{
                collection.append(Moves(row: self.row+2, col: self.col+1))
            }
        }
    
        return collection
    }
}


class Bishop: Piece{
    override init(color: Bool, row: Int, col: Int) {
        super.init(color: color, row: row, col: col)
    }
    override func avalibleMoves() -> [Moves] {
        var collection:[Moves] = []
        var j:Int = self.col+1
        //1st quad
        //When swift 3 removes C-style for loops 
        for i in 0..<8 {
            if j >= 8{
                break
            }
            let p:Piece? = Board[i][j]
            if p == nil || p!.color != self.color {
                collection.append(Moves(row: i, col: j))
            }
            j+=1
        }
        //2nd quad
        for i in 0..<8 {
            if j >= 8{
                break
            }
            let p:Piece? = Board[i][j]
            if p == nil || p!.color != self.color {
                collection.append(Moves(row: i, col: j))
            }
            j+=1
        }
        return collection
    }
}


/*Model function for checking if a move is legal. On sucess, return true, else false*/
func canPieceConformToMoveModel(row:Int, col: Int, moves:[Moves]) -> Bool {
    for i in 0..<moves.count{
        if moves[i].row == row && moves[i].col == col
        {
            return true
        }
    }
    return false
}


/*Model method for checking if a move is legal. On sucess, return true, else false*/
func canPieceConformToMoveModel(fromRow:Int, fromCol:Int, toRow:Int, toCol:Int) -> Bool {
    let p:Piece? = Board[fromRow][fromCol]
    if p == nil {
        return false
    }
    let m = p!.avalibleMoves()
    let validMove:Bool = canPieceConformToMoveModel(row: toRow, col: toCol, moves: m)
    if validMove {
        updatePieceLocationModel(p: p!, toRow: toRow, toCol: toCol)
        Board[toRow][toCol] = Board[fromRow][fromCol]
        Board[fromRow][fromCol] = nil
    }
    return validMove
}

/*Model method for updating piece object's location*/
func updatePieceLocationModel(p:Piece, toRow:Int, toCol:Int){
    p.row = toRow
    p.col = toCol
}


/*Given list of moves, it prints out [row, col]*/
func printMoves(moves: [Moves]){
    for i in 0..<moves.count {
        print("[\(moves[i].row), \(moves[i].col)] ")
    }
}
