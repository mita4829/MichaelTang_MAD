//
//  ViewController.swift
//  BTChess
//
//  Created by Michael Tang on 9/21/17.
//  Copyright © 2017 Michael Tang. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var board: UICollectionView!
    let pieceImageSet = ["brook","bknight","bbishop","bqueen","bking","bbishop","bknight","brook",
                         "bpawn","bpawn","bpawn","bpawn","bpawn","bpawn","bpawn","bpawn",
                         "","","","","","","","",
                         "","","","","","","","",
                         "","","","","","","","",
                         "","","","","","","","",
                         "pawn","pawn","pawn","pawn","pawn","pawn","pawn","pawn",
                         "rook","knight","bishop","queen","king","bishop","knight","rook",
    ]
    var movementStack:[Moves] = []
    //let pieceManage = PieceMovementManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        board.delegate = self
        setUpBoardModel()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        resizeSquaresView()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Update piece images
    func updateBoardImagesView(fromRow: Int, fromCol:Int, toRow: Int, toCol: Int){
        let translation:Int = (fromRow)*8 + fromCol
        let toTranslation:Int = (toRow)*8 + toCol
        let oldCell:BoardSquare = board.cellForItem(at: IndexPath(item: translation, section: 0)) as! BoardSquare
        let newCell:BoardSquare = board.cellForItem(at: IndexPath(item: toTranslation,section: 0)) as! BoardSquare
        
        newCell.pieceImage.image = oldCell.pieceImage.image
        oldCell.pieceImage.image = UIImage(named: "")
    }
 
    //View delegated method
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 64
    }
    
    //View delegated method
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let square:BoardSquare = collectionView.dequeueReusableCell(withReuseIdentifier: "Square", for: indexPath) as! BoardSquare
        
        //If odd, black, else white
        let whiteColor:UIColor = UIColor(colorLiteralRed: 237/255, green: 207/255, blue: 169/255, alpha: 1)
        let i = indexPath[1]
        let row:Int = i/8
        if row % 2 == 0{
            if i % 2 == 0{
                square.backgroundColor = whiteColor
            }
        }else{
            if i % 2 != 0{
                square.backgroundColor = whiteColor
            }
        }
        square.pieceImage.image = UIImage(named: (pieceImageSet[indexPath.row]))
        return square
    }
    
  
    //Controller to communicate touch events to the model
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let col:Int = indexPath[1] % 8
        let row:Int = indexPath[1] / 8
        print(String(row)+" "+String(col))
        movementStack.append(Moves(row: row, col: col))
        if movementStack.count == 2{
            printMoves(moves: movementStack)
            //stack is full, delegate move request to model 
            let validateMove:Bool = canPieceConformToMoveModel(fromRow: movementStack[0].row, fromCol: movementStack[0].col, toRow: row, toCol: col)
            print(validateMove)
            if validateMove {
                //Update View 
                updateBoardImagesView(fromRow: movementStack[0].row, fromCol: movementStack[0].col, toRow: row, toCol: col)
            }
            revertColor(indexPath: IndexPath(item: movementStack[0].row*8+movementStack[0].col, section: 0))
            movementStack.removeAll()
        }
        //Highlight touched square
        if movementStack.count == 1{
            let color:UIColor = UIColor(colorLiteralRed: 31/255, green: 200/255, blue: 51/255, alpha: 0.8)
            board.cellForItem(at: indexPath)?.backgroundColor = color
        }
    }
    
    //View method
    func resizeSquaresView(){
        let boardLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let sizeOfBoardWidth:CGFloat = self.board.frame.width
        
        let width:CGFloat = (sizeOfBoardWidth-16)/8
        
        let squareSize:CGSize = CGSize(width: width, height: width)
        
        boardLayout.itemSize = squareSize
        boardLayout.minimumLineSpacing = 0
        boardLayout.minimumInteritemSpacing = 0
        boardLayout.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8)
        self.board.setCollectionViewLayout(boardLayout, animated: true)
        
        board.layer.shadowColor = UIColor.black.cgColor
        board.layer.shadowRadius = 0.5
        board.layer.shadowOpacity = 0.5
        board.layer.shadowOffset = CGSize(width: 0, height: 25)
        
    }
    
    func revertColor(indexPath:IndexPath){
        //If odd, black, else white
        let whiteColor:UIColor = UIColor(colorLiteralRed: 237/255, green: 207/255, blue: 169/255, alpha: 1)
        let i = indexPath[1]
        let row:Int = i/8
        if row % 2 == 0{
            if i % 2 == 0{
                board.cellForItem(at: indexPath)?.backgroundColor = whiteColor
            }else{
                board.cellForItem(at: indexPath)?.backgroundColor = UIColor(colorLiteralRed: 157/255, green: 103/255, blue: 62/255, alpha: 1)
                
            }
        }else{
            if i % 2 != 0{
                board.cellForItem(at: indexPath)?.backgroundColor = whiteColor
            }else{
                board.cellForItem(at: indexPath)?.backgroundColor = UIColor(colorLiteralRed: 157/255, green: 103/255, blue: 62/255, alpha: 1)
            }
        }
    }
    
    func changeViewFromPeerEvent(packet:String){
        
    }
    
}

extension ViewController : PieceMovementManagerDelegate {
    
    func connectedDevicesChanged(manager: PieceMovementManager, connectedDevices: [String]) {
        OperationQueue.main.addOperation {
            //self.connectionsLabel.text = "Connections: \(connectedDevices)"
        }
    }
    
    func colorChanged(manager: PieceMovementManager, colorString: String) {
        OperationQueue.main.addOperation {
            /*switch colorString {
            case "red":
                self.change(color: .red)
            case "yellow":
                self.change(color: .yellow)
            default:
                NSLog("%@", "Unknown color value received: \(colorString)")
            }*/
        }
    }
    
}

