//
//  EditVC.swift
//  TicTacToe
//
//  Created by Eken Özlü on 23.05.2023.
//

import UIKit

class EditVC: UIViewController {

    @IBOutlet weak var player1TextField: UITextField!
    @IBOutlet weak var player2TextField: UITextField!
    
    @IBOutlet weak var player1ColorWell: UIColorWell!
    @IBOutlet weak var player2ColorWell: UIColorWell!
    @IBOutlet weak var gameBoardColorWell: UIColorWell!
    
    @IBOutlet weak var gameScoreSlider: UISlider!
    @IBOutlet weak var sliderValueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        player1TextField.placeholder = player1Name
        player1TextField.text = player1Name
        player2TextField.placeholder = player2Name
        player2TextField.text = player2Name
        
        player1ColorWell.selectedColor = player1Color
        player2ColorWell.selectedColor = player2Color
        
        gameBoardColorWell.selectedColor = gameBoardLineColor
        sliderValueLabel.text = String(gameScoreToWin)
        gameScoreSlider.value = Float(gameScoreToWin)
        
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        sender.value = sender.value.rounded()
        sliderValueLabel.text = String(Int(sender.value))
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        player1Name = player1TextField.text!
        player2Name = player2TextField.text!
        
        player1Color = player1ColorWell.selectedColor!
        player2Color = player2ColorWell.selectedColor!
        
        gameBoardLineColor = gameBoardColorWell.selectedColor!
        gameScoreToWin = Int(gameScoreSlider.value.rounded())
        
        player1Score = 0
        player2Score = 0
    }
    
    @IBAction func eraseButtonTapped(_ sender: UIBarButtonItem) {
        player1Name = "Player 1"
        player1TextField.text = player1Name
        player2Name = "Player 2"
        player2TextField.text = player2Name
        
        player1Color = .label
        player1ColorWell.selectedColor = player1Color
        player2Color = .label
        player2ColorWell.selectedColor = player2Color
        
        gameBoardLineColor = .label
        gameBoardColorWell.selectedColor = gameBoardLineColor
        gameScoreToWin = 3
        gameScoreSlider.value = Float(gameScoreToWin)
        sliderValueLabel.text = String(Int(gameScoreSlider.value))
    }
    
}
