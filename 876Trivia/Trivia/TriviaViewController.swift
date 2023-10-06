//
//  TriviaViewController.swift
//  Trivia
//
//  Created by Danielle McIntosh on 10/5/23.
//

import UIKit

class TriviaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var gameModels = [Question]()
    
    var currentQuestion: Question?
    
    var score = 0
    
    @IBOutlet var label: UILabel!
    
    @IBOutlet var table: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        setupQuestions()
        configureUI(question: gameModels.first!)
    }
    
    private func configureUI(question: Question) {
        label.text = question.text
        currentQuestion = question
        table.reloadData()
    }
    
    private func gameOver() {
        gameModels.append(Question(text: "Game Over! \nScore: \(score)", answers: [
        ]))
    }
    
    private func checkAnswer(answer: Answer, question: Question) -> Bool {
        return question.answers.contains(where: { $0.text == answer.text }) && answer.correct
    }
    
    private func setupQuestions() {
        gameModels.append(Question(text: "Question #1 \nCategory: Geography \n\nWhere is Jamaica located?", answers: [
            Answer(text: "A. North of Cuba", correct: false),
            Answer(text: "B. West of Panama", correct: false),
            Answer(text: "C. South of Cuba", correct: true),
            Answer(text: "D. East of Haiti", correct: false)
        ]))
        gameModels.append(Question(text: "Question #2 \nCategory: Music \n\nWhich legendary Jamaican musician and reggae pioneer is often referred to as the 'King of Reggae' and is known for songs like 'No Woman, No Cry,' 'One Love,' and 'Redemption Song'?", answers: [
            Answer(text: "A. Jimmy Cliff", correct: false),
            Answer(text: "B. Usain Bolt", correct: false),
            Answer(text: "C. Tami Chin Mitchell", correct: false),
            Answer(text: "D. Bob Marley", correct: true)
        ]))
        gameModels.append(Question(text: "Question #3 \nCategory: Geography \n\nWhich parish is known as the 'Bread Basket parish'?", answers: [
            Answer(text: "A. Kingston", correct: false),
            Answer(text: "B. St. Elizabeth", correct: true),
            Answer(text: "C. St. Catherine", correct: false),
            Answer(text: "D. Portland", correct: false)
        ]))
        gameModels.append(Question(text: "Question #4 \nCategory: Tourism \n\nWhich of the following Jamaican cities is known for its vibrant arts scene, colorful street murals, and as the birthplace of reggae music?", answers: [
            Answer(text: "A. Kingston", correct: true),
            Answer(text: "B. Negril", correct: false),
            Answer(text: "C. Port Antonio", correct: false),
            Answer(text: "D. Montego Bay", correct: false)
        ]))
        gameModels.append(Question(text: "Question #5 \n Category: History \n\nWho was the Jamaican political leader and national hero who played a pivotal role in the country's struggle for independence from British colonial rule and became Jamaica's first Prime Minister in 1962?", answers: [
            Answer(text: "A. Marcus Garvey", correct: false),
            Answer(text: "B. Paul Bogle", correct: false),
            Answer(text: "C. Andrew Holness", correct: false),
            Answer(text: "D. Alexander Bustamante", correct: true)
        ]))
        gameModels.append(Question(text: "Question #6 \nCategory: Sports \n\nWhich Jamaican sprinter, often referred to as the 'fastest man in the world,' has won multiple Olympic gold medals and set world records in the 100 meters and 200 meters events?", answers: [
            Answer(text: "A. Grace Jones", correct: false),
            Answer(text: "B. Louise Bennett-Coverley (Miss Lou)", correct: false),
            Answer(text: "C. Usain Bolt", correct: true),
            Answer(text: "D. Portia Simpson-Miller", correct: false)
        ]))
        gameModels.append(Question(text: "Question #7 \nCategory: Technology \n\nWhich Jamaican-born entrepreneur co-founded the ride-sharing service Uber and served as its CEO until 2017?", answers: [
            Answer(text: "A. Travis Kalanick", correct: true),
            Answer(text: "B. Danielle McIntosh", correct: false),
            Answer(text: "C. Michael Lee-Chin", correct: false),
            Answer(text: "D. Rohan Marley", correct: false)
        ]))
        gameModels.append(Question(text: "Question #8 \nCategory: Geography \n\nWhere is highest mountain peak in Jamaica?", answers: [
            Answer(text: "A. Don Figuerero Peak", correct: false),
            Answer(text: "B. Catherine's Peak", correct: false),
            Answer(text: "C. Blue Mountain Peak", correct: true),
            Answer(text: "D. Mount Diablo", correct: false)
        ]))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentQuestion?.answers.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = currentQuestion?.answers[indexPath.row].text
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let question = currentQuestion else {
            return
        }
        let answer = question.answers[indexPath.row]
        if checkAnswer(answer: answer, question: question) {
            score += 1
            if let index = gameModels.firstIndex(where: { $0.text == question.text }) {
                if index == (gameModels.count - 1) {
                    gameOver()
                }
                if index < (gameModels.count - 1) {
                    let nextQuestion = gameModels[index+1]
                    currentQuestion = nil
                    configureUI(question: nextQuestion)
                }
            }
        }
        else {
            score -= 1
            let alert = UIAlertController(title: "Incorrect", message: "Please try again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true)
        }
    }

}

struct Question {
    let text: String
    let answers: [Answer]
}

struct Answer {
    let text: String
    let correct: Bool
}
