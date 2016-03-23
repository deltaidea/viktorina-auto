localStorage.viktorinaAuto ?= "{}"

lastBonusQuestionId = null

originalReceiveJson = jsonClass.receiveJson


markCorrectAnswer = ( question ) ->
  savedAnswers = JSON.parse localStorage.viktorinaAuto
  correctAnswer = savedAnswers[ question.id ]
  if correctAnswer?
    question.answers[ correctAnswer ] += " [right answer!]"
  else
    question.text += " [unknown]"


saveCorrectAnswer = ( questionId, answerId ) ->
  savedAnswers = JSON.parse localStorage.viktorinaAuto
  savedAnswers[ questionId ] = answerId
  localStorage.viktorinaAuto = JSON.stringify savedAnswers


jsonClass.receiveJson = ( response ) ->

  if response.data.rightAnswer?
    # Round answer
    if response.data.game?
      game = response.data.game
      lastRoundAnswers = game.answers[ game.round ]
      lastAnswerIndex = Object.keys( lastRoundAnswers ).length
      saveCorrectAnswer game.questions[ lastAnswerIndex - 1 ], response.data.rightAnswer

    # Bonus answer
    else
      saveCorrectAnswer lastBonusQuestionId, response.data.rightAnswer


  # Round questions
  else if response.data.questions?
    for key, question of response.data.questions
      markCorrectAnswer question


  # Bonus question
  else if response.data.question
    markCorrectAnswer response.data.question
    lastBonusQuestionId = response.data.question.id

  originalReceiveJson.call jsonClass, response
