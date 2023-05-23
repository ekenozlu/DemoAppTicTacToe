//
//  ViewController.swift
//  TicTacToe
//
//  Created by Eken Özlü on 22.05.2023.
//

import UIKit

class ViewController: UIViewController {
    enum Turn {
        case Player1 //X
        case Player2 //O
    }
    
    @IBOutlet weak var player1NameLabel: UILabel!
    @IBOutlet weak var player2NameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var player1SignLabel: UILabel!
    @IBOutlet weak var player2SignLabel: UILabel!
    
    @IBOutlet weak var vStackView: UIStackView!
    @IBOutlet weak var hStackView1: UIStackView!
    @IBOutlet weak var hStackView2: UIStackView!
    @IBOutlet weak var hStackView3: UIStackView!
    
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!
    
    var firstTurn = Turn.Player1
    var currentTurn = Turn.Player1
    
    var board = [UIButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        player1NameLabel.text = player1Name
        player1NameLabel.textColor = player1Color
        player1SignLabel.textColor = player1Color
        player2NameLabel.text = player2Name
        player2NameLabel.textColor = player2Color
        player2SignLabel.textColor = player2Color
        scoreLabel.text = String(player1Score) + ":" + String(player2Score)
        
        vStackView.backgroundColor = gameBoardLineColor
        hStackView1.backgroundColor = gameBoardLineColor
        hStackView2.backgroundColor = gameBoardLineColor
        hStackView3.backgroundColor = gameBoardLineColor
        
        initBoard()
    }
    
    func initBoard(){
        board.append(a1)
        board.append(a2)
        board.append(a3)
        board.append(b1)
        board.append(b2)
        board.append(b3)
        board.append(c1)
        board.append(c2)
        board.append(c3)
    }
    
    @IBAction func boardTapAction(_ sender: UIButton) {
        addToBoard(sender)
        
        if(checkForVictory(s: cross)){
            player1Score += 1
            if (player1Score < gameScoreToWin){
                resultAlert(title: player1Name + " wins the round")
            }
            else if (player1Score == gameScoreToWin){
                gameEndAlert(title: player1Name + " wins the game")
            }
        }
        if(checkForVictory(s: circle)){
            player2Score += 1
            if (player2Score < gameScoreToWin){
                resultAlert(title: player2Name + " wins the round")
            }
            else if (player2Score == gameScoreToWin){
                gameEndAlert(title: player2Name + " wins the game")
            }
        }
        if(isBoardFull()){
            resultAlert(title: "DRAW")
        }
    }
    
    func checkForVictory(s: String) -> Bool{
        //Horizontal Victories
        if thisSymbol(a1, symbol: s) && thisSymbol(a2, symbol: s) && thisSymbol(a3, symbol: s) {
            return true
        }
        else if thisSymbol(b1, symbol: s) && thisSymbol(b2, symbol: s) && thisSymbol(b3, symbol: s) {
            return true
        }
        else if thisSymbol(c1, symbol: s) && thisSymbol(c2, symbol: s) && thisSymbol(c3, symbol: s) {
            return true
        }
        
        //Vertical Victories
        if thisSymbol(a1, symbol: s) && thisSymbol(b1, symbol: s) && thisSymbol(c1, symbol: s) {
            return true
        }
        else if thisSymbol(a2, symbol: s) && thisSymbol(b2, symbol: s) && thisSymbol(c2, symbol: s) {
            return true
        }
        else if thisSymbol(a3, symbol: s) && thisSymbol(b3, symbol: s) && thisSymbol(c3, symbol: s) {
            return true
        }
        
        //Diagonal Victories
        if thisSymbol(a1, symbol: s) && thisSymbol(b2, symbol: s) && thisSymbol(c3, symbol: s) {
            return true
        }
        else if thisSymbol(a3, symbol: s) && thisSymbol(b2, symbol: s) && thisSymbol(c1, symbol: s) {
            return true
        }
        
        return false
    }
    
    func thisSymbol(_ button: UIButton, symbol: String) -> Bool {
        return button.title(for: .normal) == symbol
    }
    
    func resultAlert(title: String){
        scoreLabel.text = String(player1Score) + ":" + String(player2Score)
        
        let ac = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Next Round", style: .default, handler: { _ in
            self.resetBoard()
        }))
        ac.addAction(UIAlertAction(title: "Reset the Game", style: .destructive, handler: { _ in
            self.resetGame()
        }))
        self.present(ac, animated: true)
    }
    
    func gameEndAlert(title: String){
        let ac = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Next Game", style: .destructive, handler: { _ in
            self.resetGame()
        }))
        self.present(ac, animated: true)
    }
    
    func resetBoard(){
        for button in board {
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        if (firstTurn == Turn.Player1){
            firstTurn = Turn.Player2
        }
        else if (firstTurn == Turn.Player2){
            firstTurn = Turn.Player1
        }
        currentTurn = firstTurn
    }
    
    func resetGame(){
        self.resetBoard()
        player1Score = 0
        player2Score = 0
        scoreLabel.text = String(player1Score) + ":" + String(player2Score)
    }
    
    func isBoardFull() -> Bool {
        for button in board {
            if (button.title(for: .normal) == nil) {
                return false
            }
        }
        return true
    }
    
    func addToBoard(_ sender:UIButton){
        if(sender.title(for: .normal) == nil){
            if(currentTurn == Turn.Player1){
                sender.setTitle(cross, for: .normal)
                sender.setTitleColor(player1Color, for: .normal)
                currentTurn = Turn.Player2
            }
            else if(currentTurn == Turn.Player2){
                sender.setTitle(circle, for: .normal)
                sender.setTitleColor(player2Color, for: .normal)
                currentTurn = Turn.Player1
            }
            sender.isEnabled = false
        }
    }
}
