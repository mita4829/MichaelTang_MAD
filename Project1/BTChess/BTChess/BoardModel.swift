//
//  BoardModel.swift
//  BTChess
//
//  Created by Michael Tang on 9/24/17.
//  Copyright © 2017 Michael Tang. All rights reserved.
//

import Foundation

//Moves
class Moves{
    var row:Int
    var col:Int
    init(row:Int, col:Int){
        self.row = row
        self.col = col
    }
}

//Event
class Event{
    var fromRow:Int
    var fromCol:Int
    var toRow:Int
    var toCol:Int
    var captured:Piece?
    //State event, castling
    //[blackKingHasMoved;whiteKingHasMoved;blackQueenRookHasMoved;blackKingRookHasMoved;whiteKingRookHasMoved;whiteQueenRookHasMoved;kingSideCastle;queenSideCastle;]
    var stateEvent:[Bool]
    //State event, en passant
    var stateEventEnPassant:Bool
    init(fromRow fr:Int, fromCol fc:Int, toRow tr:Int, toCol tc:Int, captured c:Piece?,stateEventCastle e:[Bool], stateEventEnPassant ee:Bool){
        self.fromRow = fr
        self.fromCol = fc
        self.toRow = tr
        self.toCol = tc
        self.captured = c
        self.stateEvent = e
        self.stateEventEnPassant = ee
    }
}

//Can't make classes in swift abstract...
class Piece{
    var color: Bool
    var row: Int
    var col: Int
    //avalibleMoves is an interface method in "Java" terms. 
    func avalibleMoves() -> [Moves]{
        return [Moves(row: -1, col: -1)]
    }
    init(color: Bool, id:Int, row: Int, col: Int) {
        self.color = color
        self.row = row
        self.col = col
    }
}
/*
 [0-7] pawn
 [8-9] rook
 [10-11] knight
 [12-13] bishop
 [14] queen
 [15] king
 */

var Events:[Event] = []
var Board: [[Piece?]] = Array(repeating: Array(repeating: nil, count:8), count: 8)
var white: [Piece?] = Array(repeating: nil, count: 16)
var black: [Piece?] = Array(repeating: nil, count: 16)


class Pawn: Piece{
    override init(color:Bool, id:Int, row:Int, col: Int) {
        super.init(color: color, id:id, row: row, col: col)
    }
    override func avalibleMoves() -> [Moves] {
        var collection:[Moves] = []
        //Black pawn
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
                collection.append(Moves(row: self.row+1, col: self.col-1))
            }
            //Capture square right
            if self.col < 7 && self.row < 7 && Board[self.row+1][self.col+1] != nil && (Board[self.row+1][self.col+1]!.color) != self.color {
                collection.append(Moves(row: self.row+1, col: self.col+1))
            }
            
            //Work on En passant

        }else{
            //white pawn
            //Pawn's first move
            if self.row == 6 && Board[self.row-1][self.col] == nil && Board[self.row-2][self.col] == nil {
                collection.append(Moves(row: self.row-2,col: self.col))
            }
            //forward square
            if self.row > 0 && Board[self.row-1][col] == nil{
                collection.append(Moves(row: self.row-1, col: self.col))
            }
            //Capture square left
            if self.row > 0 && self.col > 0 && Board[self.row-1][self.col-1] != nil && (Board[self.row-1][self.col-1]!.color) != self.color {
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
    override init(color:Bool, id:Int, row:Int, col: Int) {
        super.init(color: color, id:id, row: row, col: col)
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
                collection.append(Moves(row: self.row+2, col: self.col-1))
            }
        }
    
        return collection
    }
}


class Bishop: Piece{
    override init(color: Bool, id:Int, row: Int, col: Int) {
        super.init(color: color, id:id, row: row, col: col)
    }
    override func avalibleMoves() -> [Moves] {
        var collection:[Moves] = []
        var j:Int = self.col+1
        //1st quad br
        //When swift 3 removes C-style for loops 
        for i in self.row+1..<8 {
            if j >= 8{
                break
            }
            let p:Piece? = Board[i][j]
            if p == nil {
                collection.append(Moves(row: i, col: j))
            }else if p!.color != self.color{
                collection.append(Moves(row: i, col: j))
                break
            }
            if p?.color == self.color{
                break
            }
            j+=1
        }
        //2nd quad bl
        j = self.col-1
        for i in self.row+1..<8 {
            if j < 0{
                break
            }
            let p:Piece? = Board[i][j]
            if p == nil {
                collection.append(Moves(row: i, col: j))
            }else if p!.color != self.color{
                collection.append(Moves(row: i, col: j))
                break
            }
            if p?.color == self.color{
                break
            }
            j-=1
        }
        //3rd quad tl
        j = self.col-1
        for i in (0..<self.row).reversed(){
            if j < 0{
                break
            }
            let p:Piece? = Board[i][j]
            if p == nil {
                collection.append(Moves(row: i, col: j))
            }else if p!.color != self.color{
                collection.append(Moves(row: i, col: j))
                break
            }
            if p?.color == self.color{
                break
            }
            j-=1
        }
        //4th quad tr
        j = self.col+1
        for i in (0..<self.row).reversed() {
            if j >= 8{
                break
            }
            let p:Piece? = Board[i][j]
            if p == nil {
                collection.append(Moves(row: i, col: j))
            }else if p!.color != self.color{
                collection.append(Moves(row: i, col: j))
                break
            }
            if p?.color == self.color{
                break
            }
            j+=1
        }

        return collection
    }
}

class Rook: Piece{
    override init(color: Bool, id:Int, row: Int, col: Int) {
        super.init(color: color, id:id, row: row, col: col)
    }
    override func avalibleMoves() -> [Moves] {
        var collection:[Moves] = []
        //down
        for i in self.row+1..<8 {
            let j:Int = self.col
            let p:Piece? = Board[i][j]
            if p == nil {
                collection.append(Moves(row: i, col: j))
            }else if p!.color != self.color{
                collection.append(Moves(row: i, col: j))
                break
            }
            if p?.color == self.color{
                break
            }
        }
        //right
        for j in self.col+1..<8 {
            let i:Int = self.row
            let p:Piece? = Board[i][j]
            if p == nil {
                collection.append(Moves(row: i, col: j))
            }else if p!.color != self.color{
                collection.append(Moves(row: i, col: j))
                break
            }
            if p?.color == self.color{
                break
            }
        }
        //up
        for i in (0..<self.row).reversed(){
            let j:Int = self.col
            let p:Piece? = Board[i][j]
            if p == nil {
                collection.append(Moves(row: i, col: j))
            }else if p!.color != self.color{
                collection.append(Moves(row: i, col: j))
                break
            }
            if p?.color == self.color{
                break
            }
        }
        //left
        for j in (0..<self.col).reversed() {
            let i:Int = self.row
            let p:Piece? = Board[i][j]
            if p == nil {
                collection.append(Moves(row: i, col: j))
            }else if p!.color != self.color{
                collection.append(Moves(row: i, col: j))
                break
            }
            if p?.color == self.color{
                break
            }
        }
        
        return collection
    }
}


class Queen:Piece{
    override init(color:Bool, id:Int, row:Int, col: Int) {
        super.init(color: color, id:id, row: row, col: col)
    }
    override func avalibleMoves() -> [Moves] {
        var collection:[Moves] = []
        //down
        for i in self.row+1..<8 {
            let j:Int = self.col
            let p:Piece? = Board[i][j]
            if p == nil {
                collection.append(Moves(row: i, col: j))
            }else if p!.color != self.color{
                collection.append(Moves(row: i, col: j))
                break
            }
            if p?.color == self.color{
                break
            }
        }
        //right
        for j in self.col+1..<8 {
            let i:Int = self.row
            let p:Piece? = Board[i][j]
            if p == nil {
                collection.append(Moves(row: i, col: j))
            }else if p!.color != self.color{
                collection.append(Moves(row: i, col: j))
                break
            }
            if p?.color == self.color{
                break
            }
        }
        //up
        for i in (0..<self.row).reversed(){
            let j:Int = self.col
            let p:Piece? = Board[i][j]
            if p == nil {
                collection.append(Moves(row: i, col: j))
            }else if p!.color != self.color{
                collection.append(Moves(row: i, col: j))
                break
            }
            if p?.color == self.color{
                break
            }
        }
        //left
        for j in (0..<self.col).reversed() {
            let i:Int = self.row
            let p:Piece? = Board[i][j]
            if p == nil {
                collection.append(Moves(row: i, col: j))
            }else if p!.color != self.color{
                collection.append(Moves(row: i, col: j))
                break
            }
            if p?.color == self.color{
                break
            }
        }
        var j:Int = self.col+1
        //1st quad br
        //When swift 3 removes C-style for loops
        for i in self.row+1..<8 {
            if j >= 8{
                break
            }
            let p:Piece? = Board[i][j]
            if p == nil {
                collection.append(Moves(row: i, col: j))
            }else if p!.color != self.color{
                collection.append(Moves(row: i, col: j))
                break
            }
            if p?.color == self.color{
                break
            }
            j+=1
        }
        //2nd quad bl
        j = self.col-1
        for i in self.row+1..<8 {
            if j < 0{
                break
            }
            let p:Piece? = Board[i][j]
            if p == nil {
                collection.append(Moves(row: i, col: j))
            }else if p!.color != self.color{
                collection.append(Moves(row: i, col: j))
                break
            }
            if p?.color == self.color{
                break
            }
            j-=1
        }
        //3rd quad tl
        j = self.col-1
        for i in (0..<self.row).reversed(){
            if j < 0{
                break
            }
            let p:Piece? = Board[i][j]
            if p == nil {
                collection.append(Moves(row: i, col: j))
            }else if p!.color != self.color{
                collection.append(Moves(row: i, col: j))
                break
            }
            if p?.color == self.color{
                break
            }
            j-=1
        }
        //4th quad tr
        j = self.col+1
        for i in (0..<self.row).reversed() {
            if j >= 8{
                break
            }
            let p:Piece? = Board[i][j]
            if p == nil {
                collection.append(Moves(row: i, col: j))
            }else if p!.color != self.color{
                collection.append(Moves(row: i, col: j))
                break
            }
            if p?.color == self.color{
                break
            }
            j+=1
        }
        return collection
    }
}

func canWhiteKingGoHere(Row row:Int, Col col:Int) -> Bool {
    for i in 0..<16 {
        if black[i] != nil {
            let moves:[Moves] = black[i]!.avalibleMoves()
            for j in 0..<moves.count{
                if moves[j].row == row && moves[j].col == col {
                    return false
                }
            }
        }
    }
    return true
}

func canBlackKingGoHere(Row row:Int, Col col:Int) -> Bool {
    for i in 0..<16 {
        if white[i] != nil {
            let moves:[Moves] = white[i]!.avalibleMoves()
            for j in 0..<moves.count{
                if moves[j].row == row && moves[j].col == col {
                    return false
                }
            }
        }
    }
    return true
}

class King:Piece{
    //Crashing. Need to implement a move array to store previous moves 
    override init(color:Bool, id:Int, row:Int, col: Int) {
        super.init(color: color, id:id, row: row, col: col)
    }
    override func avalibleMoves() -> [Moves] {
        var collection:[Moves] = []
        //up
        if self.row > 0 {
            let p:Piece? = Board[self.row-1][self.col]
            var rtn:Bool
            if(self.color){
                rtn = canWhiteKingGoHere(Row: self.row-1, Col: self.col)
            }else{
                rtn = canBlackKingGoHere(Row: self.row-1, Col: self.col)
            }
            if((p == nil || p!.color != self.color) && rtn){
                collection.append(Moves(row: self.row-1,col: self.col))
            }
        }
        //Left
        if self.col < 7 {
            let p:Piece? = Board[self.row][self.col+1]
            var rtn:Bool
            if(self.color){
                rtn = canWhiteKingGoHere(Row: self.row, Col: self.col+1)
            }else{
                rtn = canBlackKingGoHere(Row: self.row, Col: self.col+1)
            }
            if((p == nil || p!.color != self.color) && rtn){
                collection.append(Moves(row: self.row,col: self.col+1))
            }
        }
        //Down
        if self.row < 7 {
            let p:Piece? = Board[self.row+1][self.col]
            var rtn:Bool
            if(self.color){
                rtn = canWhiteKingGoHere(Row: self.row+1, Col: self.col)
            }else{
                rtn = canBlackKingGoHere(Row: self.row+1, Col: self.col)
            }
            if((p == nil || p!.color != self.color) && rtn){
                collection.append(Moves(row: self.row+1,col: self.col))
            }
        }
        //Left
        if self.col > 0 {
            let p:Piece? = Board[self.row][self.col-1]
            var rtn:Bool
            if(self.color){
                rtn = canWhiteKingGoHere(Row: self.row, Col: self.col-1)
            }else{
                rtn = canBlackKingGoHere(Row: self.row, Col: self.col-1)
            }
            if((p == nil || p!.color != self.color) && rtn){
                collection.append(Moves(row: self.row,col: self.col-1))
            }
        }
        //Up-right
        if self.col < 7 && self.row > 0 {
            let p:Piece? = Board[self.row-1][self.col+1]
            var rtn:Bool
            if(self.color){
                rtn = canWhiteKingGoHere(Row: self.row-1, Col: self.col+1)
            }else{
                rtn = canBlackKingGoHere(Row: self.row-1, Col: self.col+1)
            }
            if((p == nil || p!.color != self.color) && rtn){
                collection.append(Moves(row: self.row-1,col: self.col+1))
            }
        }
        //bottom-right
        if self.col < 7 && self.row < 7 {
            let p:Piece? = Board[self.row+1][self.col+1]
            var rtn:Bool
            if(self.color){
                rtn = canWhiteKingGoHere(Row: self.row+1, Col: self.col+1)
            }else{
                rtn = canBlackKingGoHere(Row: self.row+1, Col: self.col+1)
            }
            if((p == nil || p!.color != self.color) && rtn){
                collection.append(Moves(row: self.row+1,col: self.col+1))
            }
        }
        //bottom-left
        if self.col > 0 && self.row < 7 {
            let p:Piece? = Board[self.row+1][self.col-1]
            var rtn:Bool
            if(self.color){
                rtn = canWhiteKingGoHere(Row: self.row+1, Col: self.col-1)
            }else{
                rtn = canBlackKingGoHere(Row: self.row+1, Col: self.col-1)
            }
            if((p == nil || p!.color != self.color) && rtn){
                collection.append(Moves(row: self.row+1,col: self.col-1))
            }
        }
        //top-left
        if self.col > 0 && self.row > 0 {
            let p:Piece? = Board[self.row-1][self.col-1]
            var rtn:Bool
            if(self.color){
                rtn = canWhiteKingGoHere(Row: self.row-1, Col: self.col-1)
            }else{
                rtn = canBlackKingGoHere(Row: self.row-1, Col: self.col-1)
            }
            if((p == nil || p!.color != self.color) && rtn){
                collection.append(Moves(row: self.row-1,col: self.col-1))
            }
        }
        //TODO finish king
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


/*Model method for check if white king is in check*/
func isWhiteInCheck() -> Bool {
    let p:Piece = white[15]!
    for i in 0..<16 {
        if black[i] != nil {
            let moves:[Moves] = black[i]!.avalibleMoves()
            for j in 0..<moves.count{
                if moves[j].row == p.row && moves[j].col == p.col {
                    return true
                }
            }
        }
    }
    return false
}

/*Model method for check if black king is in check*/
func isBlackInCheck() -> Bool {
    let p:Piece = black[15]!
    for i in 0..<16 {
        if white[i] != nil {
            let moves:[Moves] = white[i]!.avalibleMoves()
            for j in 0..<moves.count{
                if moves[j].row == p.row && moves[j].col == p.col {
                    return true
                }
            }
        }
    }
    return false
}

/*Given list of moves, it prints out [row, col]*/
func printMoves(moves: [Moves]){
    for i in 0..<moves.count {
        print("[\(moves[i].row), \(moves[i].col)] ")
    }
}

func setUpBoardModel(){
    for i in 0..<8{
        let w:Piece = Pawn(color: true,id: i,row: 6,col: i)
        let b:Piece = Pawn(color: false,id: i,row: 1,col: i)
        white[i] = w
        black[i] = b
        Board[6][i] = w
        Board[1][i] = b
        //Add more pieces later
    }
    let lbishop:Piece = Bishop(color:true, id: 12, row:7, col:2)
    let rbishop:Piece = Bishop(color:true, id: 13, row:7, col:5)
    white[12] = lbishop
    white[13] = rbishop
    Board[7][2] = lbishop
    Board[7][5] = rbishop
    
    let blbishop:Piece = Bishop(color:false, id: 12, row:0, col:2)
    let brbishop:Piece = Bishop(color:false, id: 13, row:0, col:5)
    black[12] = blbishop
    black[13] = brbishop
    Board[0][2] = blbishop
    Board[0][5] = brbishop
    
    let lrook:Piece = Rook(color:true, id: 8, row:7, col:0)
    let rrook:Piece = Rook(color:true, id: 9, row:7, col:7)
    white[8] = lrook
    white[9] = rrook
    Board[7][0] = lrook
    Board[7][7] = rrook
    
    let blrook:Piece = Rook(color:false, id: 8, row:0, col:0)
    let brrook:Piece = Rook(color:false, id: 9, row:0, col:7)
    black[8] = blrook
    black[9] = brrook
    Board[0][0] = blrook
    Board[0][7] = brrook
    
    let lknight:Piece = Knight(color:true, id: 10, row:7, col:1)
    let rknight:Piece = Knight(color:true, id: 11, row:7, col:6)
    white[10] = lknight
    white[11] = rknight
    Board[7][1] = lknight
    Board[7][6] = rknight
    
    let blknight:Piece = Knight(color:false, id: 10, row:0, col:1)
    let brknight:Piece = Knight(color:false, id: 11, row:0, col:6)
    black[10] = lknight
    black[11] = rknight
    Board[0][1] = blknight
    Board[0][6] = brknight
    
    let bqueen:Piece = Queen(color:false, id: 14, row:0, col:3)
    let queen:Piece = Queen(color:true, id: 14, row:7, col:3)
    black[14] = bqueen
    white[14] = queen
    Board[7][3] = queen
    Board[0][3] = bqueen
    
    /*let king:Piece = King(color:true, id: 15, row:0, col:4)
    let bking:Piece = King(color:false, id: 15, row:7, col:4)
    black[15] = bking
    white[15] = king
    Board[7][4] = king
    Board[0][4] = bking*/
}
