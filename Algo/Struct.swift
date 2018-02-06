//
//  Struct.swift
//  testYourself
//
//  Created by Arthur BRICQ on 05/02/2018.
//  Copyright © 2018 Arthur BRICQ. All rights reserved.
//

import Foundation

// DATA MODEL FOR THE GAME : Three classes for the data model of the game : One quizz is made of several question, and for each question we have several answers, and for each answers we have several benefits.
struct OneAnswer {
    var answer : String
    var benefits : [Int] // Ce tableau d'entier indique de combien de points sur 10 une propriété doit être augmenté si l'utilisateur choisi cette réponse là. A la fin de toutes les questions, on fait la somme pondérée de tous les points de toutes les catégories afin de déterminer la personnalité de l'utilisateur.
}

struct OnePartOfaQuizz {
    var questionLabel : String // C'est le titre de la question.
    var answers : [OneAnswer] // Ce sont toutes les réponses liées à cette question.
}

class OneQuizz
{
    var title : String
    var allQuestions : [OnePartOfaQuizz]
    var properties : [String]
    
    init(title: String, allQuestios: [OnePartOfaQuizz], properties: [String]) {
        self.title = title
        self.allQuestions = allQuestios
        self.properties = properties
    }
}

// DATA MODEL FOR THE CHECKED ANSWERS BY THE PLAYER :
struct OneAnswerChecked {
    // For each question, when the player tap a button, it will mark to true the specific number of the section where the player tapped.
    var isChecked : [Bool]
    
}

var OneQuizzChecked = [OneAnswerChecked]() // This is the variable with all the results.

func initialize_OneQuizzChecked() {
    // We must put false for each answers in eahc questions.
    for i in 0...activeQuizz.allQuestions.count-1 // i représente l'index de toutes les questions (première question, deuxième question, ... , dernière question)
    {
        var TMP = [Bool]()
        for j in 0...activeQuizz.allQuestions[i].answers.count-1 // j représente l'index de chaque réponse parmis une question (première réponse de la ième question, ... , dernière réponse de la ième question)
        {
            TMP.append(false)
        }
        var TMP2 = OneAnswerChecked(isChecked: TMP)
        OneQuizzChecked.append(TMP2)
        TMP.removeAll()
        TMP2.isChecked.removeAll()
    }
}

func describe_OneQuizzChecked() {
    // This function is just to output all the elements of this array
    for i in 0...activeQuizz.allQuestions.count-1 // i représente l'index de toutes les questions (première question, deuxième question, ... , dernière question)
    {
        print("Question \(i)")
        for j in 0...activeQuizz.allQuestions[i].answers.count-1 // j représente l'index de chaque réponse parmis une question (première réponse de la ième question, ... , dernière réponse de la ième question)
        {
            print(OneQuizzChecked[i].isChecked[j])
        }
    }
}


// Création du premier quizz par A.B.
// Are you smart ?
// benefits :
let firstBenefits = ["good in physic/math","idiot","good in humain science","has lot of logic","not very studient but it's okay","he has a great mind","aware of things around him"]
// First question
let q1 = OnePartOfaQuizz(questionLabel: "What is a prime number", answers: [OneAnswer(answer: "number 1 is the only one.", benefits: [0,10,0,3,8,0,0]), OneAnswer(answer: "A number that has no other dividors than itself", benefits: [7,0,0,5,0,5,5]), OneAnswer(answer: "This doesn't mean anything to me.", benefits: [0,5,5,3,3,2,0])])

// Second question: why does water evaporates.
let ans1 = OneAnswer(answer: "Because the temperature and the pressure are making it passing from liquid state to gaseous state.", benefits: [10,0,0,10,4,5,10])
let ans2 = OneAnswer(answer: "This is because the air above the water is changing color", benefits: [0,10,0,0,10,5,2])
let ans3 = OneAnswer(answer: "This is the wish of god", benefits: [0,5,5,5,0,0,0])
let q2 = OnePartOfaQuizz(questionLabel: "Why does water evaporates", answers: [ans1,ans2,ans3])

// Third question, during a normal day, what are you activities
let anss1 = OneAnswer(answer: "I Study/work during most of the day, and I rest before meeting with my friends/family. Also, I enjoy reading books/papers", benefits: [5,0,5,10,0,10,10])
let anss2 = OneAnswer(answer: "Mostly, i drink & drog myself with my friends. Rest is borin.", benefits: [0,10,0,0,10,0,0])
let anss3 = OneAnswer(answer: "I like to play games sometimes, I pass time on facebook but also check my works.", benefits: [5,2,5,6,6,6,6])
let q3 = OnePartOfaQuizz(questionLabel: "during a normal day, what are you activities ?", answers: [anss1,anss2,anss3])

// Fourth question : what is your favorite field.
let ansss1 = OneAnswer(answer: "Science", benefits: [10,0,0,0,0,0,0])
let ansss2 = OneAnswer(answer: "Lecture of books", benefits: [0,0,10,0,0,0,0])
let ansss3 = OneAnswer(answer: "Art", benefits: [0,0,0,10,0,0,0])
let ansss4 = OneAnswer(answer: "Religion", benefits: [0,3,3,0,10,0,3])
let q4 = OnePartOfaQuizz(questionLabel: "what is your favorite field?", answers: [ansss1,ansss2,ansss3,ansss4])

let firstQuizz = OneQuizz(title: "Are you really Smart ?", allQuestios: [q1,q2,q3,q4], properties: firstBenefits)

var activeQuizz = firstQuizz // This is the test that the player decides to play.
var activeQuestionIdentifier = 0  // the is the question that is being displayed.

